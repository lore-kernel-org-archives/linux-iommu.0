Return-Path: <SRS0=9Lhb=MH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F563C636C7
	for <iommu@archiver.kernel.org>; Thu, 15 Jul 2021 17:49:15 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27A29613C7
	for <iommu@archiver.kernel.org>; Thu, 15 Jul 2021 17:49:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27A29613C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id DF61D60E50;
	Thu, 15 Jul 2021 17:49:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sXOrlIgYryIq; Thu, 15 Jul 2021 17:49:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id CA9CB60BD6;
	Thu, 15 Jul 2021 17:49:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A52C5C001A;
	Thu, 15 Jul 2021 17:49:13 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D4E3CC000E
 for <iommu@lists.linux-foundation.org>; Thu, 15 Jul 2021 17:49:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C369A60E50
 for <iommu@lists.linux-foundation.org>; Thu, 15 Jul 2021 17:49:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yVKvrefZ6fiC for <iommu@lists.linux-foundation.org>;
 Thu, 15 Jul 2021 17:49:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D7E5560BD6
 for <iommu@lists.linux-foundation.org>; Thu, 15 Jul 2021 17:49:09 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10046"; a="271712593"
X-IronPort-AV: E=Sophos;i="5.84,243,1620716400"; d="scan'208";a="271712593"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jul 2021 10:49:04 -0700
X-IronPort-AV: E=Sophos;i="5.84,243,1620716400"; d="scan'208";a="489539779"
Received: from otc-nc-03.jf.intel.com (HELO otc-nc-03) ([10.54.39.36])
 by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jul 2021 10:49:03 -0700
Date: Thu, 15 Jul 2021 10:48:36 -0700
From: "Raj, Ashok" <ashok.raj@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [RFC v2] /dev/iommu uAPI proposal
Message-ID: <20210715174836.GB593686@otc-nc-03>
References: <BN9PR11MB5433B1E4AE5B0480369F97178C189@BN9PR11MB5433.namprd11.prod.outlook.com>
 <7ea349f8-8c53-e240-fe80-382954ba7f28@huawei.com>
 <BN9PR11MB5433A9B792441CAF21A183A38C129@BN9PR11MB5433.namprd11.prod.outlook.com>
 <a8edb2c1-9c9c-6204-072c-4f1604b7dace@huawei.com>
 <BN9PR11MB54336D6A8CAE31F951770A428C129@BN9PR11MB5433.namprd11.prod.outlook.com>
 <20210715124813.GC543781@nvidia.com>
 <20210715135757.GC590891@otc-nc-03>
 <20210715152325.GF543781@nvidia.com>
 <20210715162141.GA593686@otc-nc-03>
 <20210715171826.GG543781@nvidia.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210715171826.GG543781@nvidia.com>
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

On Thu, Jul 15, 2021 at 02:18:26PM -0300, Jason Gunthorpe wrote:
> On Thu, Jul 15, 2021 at 09:21:41AM -0700, Raj, Ashok wrote:
> > On Thu, Jul 15, 2021 at 12:23:25PM -0300, Jason Gunthorpe wrote:
> > > On Thu, Jul 15, 2021 at 06:57:57AM -0700, Raj, Ashok wrote:
> > > > On Thu, Jul 15, 2021 at 09:48:13AM -0300, Jason Gunthorpe wrote:
> > > > > On Thu, Jul 15, 2021 at 06:49:54AM +0000, Tian, Kevin wrote:
> > > > > 
> > > > > > No. You are right on this case. I don't think there is a way to 
> > > > > > differentiate one mdev from the other if they come from the
> > > > > > same parent and attached by the same guest process. In this
> > > > > > case the fault could be reported on either mdev (e.g. the first
> > > > > > matching one) to get it fixed in the guest.
> > > > > 
> > > > > If the IOMMU can't distinguish the two mdevs they are not isolated
> > > > > and would have to share a group. Since group sharing is not supported
> > > > > today this seems like a non-issue
> > > > 
> > > > Does this mean we have to prevent 2 mdev's from same pdev being assigned to
> > > > the same guest? 
> > > 
> > > No, it means that the IOMMU layer has to be able to distinguish them.
> > 
> > Ok, the guest has no control over it, as it see 2 separate pci devices and
> > thinks they are all different.
> > 
> > Only time when it can fail is during the bind operation. From guest
> > perspective a bind in vIOMMU just turns into a write to local table and a
> > invalidate will cause the host to update the real copy from the shadow.
> > 
> > There is no way to fail the bind? and Allocation of the PASID is also a
> > separate operation and has no clue how its going to be used in the guest.
> 
> You can't attach the same RID to the same PASID twice. The IOMMU code
> should prevent this.
> 
> As we've talked about several times, it seems to me the vIOMMU
> interface is misdesigned for the requirements you have. The hypervisor
> should have a role in allocating the PASID since there are invisible
> hypervisor restrictions. This is one of them.

Allocating a PASID is a separate step from binding, isn't it? In vt-d we
have a virtual command interface that can fail an allocation of PASID. But
which device its bound to is a dynamic thing that only gets at bind_mm()
right?

> 
> > Do we have any isolation requirements here? its the same process. So if the
> > page-request it sent to guest and even if you report it for mdev1, after
> > the PRQ is resolved by guest, the request from mdev2 from the same guest
> > should simply work?
> 
> I think we already talked about this and said it should not be done.

I get the should not be done, I'm wondering where should that be
implemented?
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
