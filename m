Return-Path: <SRS0=0fjx=PH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7095C433EF
	for <iommu@archiver.kernel.org>; Tue, 19 Oct 2021 16:53:56 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 376186113D
	for <iommu@archiver.kernel.org>; Tue, 19 Oct 2021 16:53:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 376186113D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id EEB3160B33;
	Tue, 19 Oct 2021 16:53:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id e4cjdkWWOJdw; Tue, 19 Oct 2021 16:53:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id DFA9360723;
	Tue, 19 Oct 2021 16:53:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B3F5AC000F;
	Tue, 19 Oct 2021 16:53:54 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6A686C000D
 for <iommu@lists.linux-foundation.org>; Tue, 19 Oct 2021 16:53:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4480F402A8
 for <iommu@lists.linux-foundation.org>; Tue, 19 Oct 2021 16:53:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hwSo22w-MxAH for <iommu@lists.linux-foundation.org>;
 Tue, 19 Oct 2021 16:53:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2568C403D6
 for <iommu@lists.linux-foundation.org>; Tue, 19 Oct 2021 16:53:50 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10142"; a="228448608"
X-IronPort-AV: E=Sophos;i="5.87,164,1631602800"; d="scan'208";a="228448608"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Oct 2021 09:53:44 -0700
X-IronPort-AV: E=Sophos;i="5.87,164,1631602800"; d="scan'208";a="462833841"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
 by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Oct 2021 09:53:43 -0700
Date: Tue, 19 Oct 2021 09:57:34 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [RFC 01/20] iommu/iommufd: Add /dev/iommu core
Message-ID: <20211019095734.2a3fb785@jacob-builder>
In-Reply-To: <20211015111807.GD2744544@nvidia.com>
References: <20210919063848.1476776-1-yi.l.liu@intel.com>
 <20210919063848.1476776-2-yi.l.liu@intel.com>
 <20210921154138.GM327412@nvidia.com>
 <PH0PR11MB56583356619B3ECC23AB1BA8C3B99@PH0PR11MB5658.namprd11.prod.outlook.com>
 <20211015111807.GD2744544@nvidia.com>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "kwankhede@nvidia.com" <kwankhede@nvidia.com>, "hch@lst.de" <hch@lst.de>,
 "jean-philippe@linaro.org" <jean-philippe@linaro.org>, "Jiang,
 Dave" <dave.jiang@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 "corbet@lwn.net" <corbet@lwn.net>, "Tian, Kevin" <kevin.tian@intel.com>,
 "parav@mellanox.com" <parav@mellanox.com>,
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

Hi Jason,

On Fri, 15 Oct 2021 08:18:07 -0300, Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Fri, Oct 15, 2021 at 09:18:06AM +0000, Liu, Yi L wrote:
> 
> > >   Acquire from the xarray is
> > >    rcu_lock()
> > >    ioas = xa_load()
> > >    if (ioas)
> > >       if (down_read_trylock(&ioas->destroying_lock))  
> > 
> > all good suggestions, will refine accordingly. Here destroying_lock is a
> > rw_semaphore. right? Since down_read_trylock() accepts a rwsem.  
> 
> Yes, you probably need a sleeping lock
> 
I am not following why we want a sleeping lock inside RCU protected
section?

For ioas, do we really care about the stale data to choose rw_lock vs RCU?
Destroying can be kfree_rcu?
> Jason


Thanks,

Jacob
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
