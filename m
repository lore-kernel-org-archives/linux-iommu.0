Return-Path: <SRS0=AdPL=CY=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68E24C433E2
	for <iommu@archiver.kernel.org>; Tue, 15 Sep 2020 19:26:48 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D424D20770
	for <iommu@archiver.kernel.org>; Tue, 15 Sep 2020 19:26:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D424D20770
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 5D807864BD;
	Tue, 15 Sep 2020 19:26:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CvqnQpDmImyz; Tue, 15 Sep 2020 19:26:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id B8DBA85F92;
	Tue, 15 Sep 2020 19:26:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AB479C0864;
	Tue, 15 Sep 2020 19:26:46 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C2150C0051
 for <iommu@lists.linux-foundation.org>; Tue, 15 Sep 2020 19:26:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 9B4842045E
 for <iommu@lists.linux-foundation.org>; Tue, 15 Sep 2020 19:26:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IPTvDhcrJY+j for <iommu@lists.linux-foundation.org>;
 Tue, 15 Sep 2020 19:26:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by silver.osuosl.org (Postfix) with ESMTPS id BBBFC2043A
 for <iommu@lists.linux-foundation.org>; Tue, 15 Sep 2020 19:26:43 +0000 (UTC)
IronPort-SDR: 99lfsOW4sJPMd3XvCeGYL+yjWhcZqqMq6PTc5IUfScYvd0UyP+uUaVgPzeeryTQJa1vLdwLMfo
 VKKzmg/3LDXg==
X-IronPort-AV: E=McAfee;i="6000,8403,9745"; a="160266650"
X-IronPort-AV: E=Sophos;i="5.76,430,1592895600"; d="scan'208";a="160266650"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Sep 2020 12:26:40 -0700
IronPort-SDR: hhhAAG+hfXZ3oD4WJ5QXwumRC8Gx2W6szlEll9sgaTobnOaC2A5t1sTEB3EUHv1UnJ388HHsRk
 FNP12tMYpCbw==
X-IronPort-AV: E=Sophos;i="5.76,430,1592895600"; d="scan'208";a="482954094"
Received: from otc-nc-03.jf.intel.com (HELO otc-nc-03) ([10.54.39.36])
 by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Sep 2020 12:26:39 -0700
Date: Tue, 15 Sep 2020 12:26:32 -0700
From: "Raj, Ashok" <ashok.raj@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v7 00/16] vfio: expose virtual Shared Virtual Addressing
 to VMs
Message-ID: <20200915192632.GA71024@otc-nc-03>
References: <20200914162247.GA63399@otc-nc-03>
 <20200914163354.GG904879@nvidia.com>
 <20200914105857.3f88a271@x1.home>
 <20200914174121.GI904879@nvidia.com>
 <20200914122328.0a262a7b@x1.home>
 <20200914190057.GM904879@nvidia.com>
 <20200914224438.GA65940@otc-nc-03>
 <20200915113341.GW904879@nvidia.com>
 <20200915181154.GA70770@otc-nc-03>
 <20200915184510.GB1573713@nvidia.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200915184510.GB1573713@nvidia.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Cc: yi.y.sun@intel.com, Jean-Philippe Brucker <jean-philippe@linaro.org>,
 kevin.tian@intel.com, Ashok Raj <ashok.raj@intel.com>, kvm@vger.kernel.org,
 iommu@lists.linux-foundation.org, stefanha@gmail.com,
 Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 jun.j.tian@intel.com, Alex Williamson <alex.williamson@redhat.com>,
 Jacon Jun Pan <jacob.jun.pan@intel.com>, hao.wu@intel.com
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

On Tue, Sep 15, 2020 at 03:45:10PM -0300, Jason Gunthorpe wrote:
> On Tue, Sep 15, 2020 at 11:11:54AM -0700, Raj, Ashok wrote:
> > > PASID applies widely to many device and needs to be introduced with a
> > > wide community agreement so all scenarios will be supportable.
> > 
> > True, reading some of the earlier replies I was clearly confused as I
> > thought you were talking about mdev again. But now that you stay it, you
> > have moved past mdev and its the PASID interfaces correct?
> 
> Yes, we agreed mdev for IDXD at LPC, didn't talk about PASID.
> 
> > For the native user applications have just 1 PASID per
> > process. There is no need for a quota management.
> 
> Yes, there is. There is a limited pool of HW PASID's. If one user fork
> bombs it can easially claim an unreasonable number from that pool as
> each process will claim a PASID. That can DOS the rest of the system.

Not sure how you had this played out.. For PASID used in ENQCMD today for
our SVM usages, we *DO* not automatically propagate or allocate new PASIDs. 

The new process needs to bind to get a PASID for its own use. For threads
of same process the PASID is inherited. For forks(), we do not
auto-allocate them. Since PASID isn't a sharable resource much like how you
would not pass mmio mmap's to forked processes that cannot be shared correct?
Such as your doorbell space for e.g. 

> 
> If PASID DOS is a worry then it must be solved at the IOMMU level for
> all user applications that might trigger a PASID allocation. VFIO is
> not special.

Feels like you can simply avoid the PASID DOS rather than permit it to
happen. 
> 
> > IIUC, you are asking that part of the interface to move to a API interface
> > that potentially the new /dev/sva and VFIO could share? I think the API's
> > for PASID management themselves are generic (Jean's patchset + Jacob's
> > ioasid set management).
> 
> Yes, the in kernel APIs are pretty generic now, and can be used by
> many types of drivers.

Good, so there is no new requirements here I suppose.
> 
> As JasonW kicked this off, VDPA will need all this identical stuff
> too. We already know this, and I think Intel VDPA HW will need it, so
> it should concern you too :)

This is one of those things that I would disagree and commit :-).. 

> 
> A PASID vIOMMU solution sharable with VDPA and VFIO, based on a PASID
> control char dev (eg /dev/sva, or maybe /dev/iommu) seems like a
> reasonable starting point for discussion.

Looks like now we are getting closer to what we need. :-)

Given that PASID api's are general purpose today and any driver can use it
to take advantage. VFIO fortunately or unfortunately has the IOMMU things
abstracted. I suppose that support is also mostly built on top of the
generic iommu* api abstractions in a vendor neutral way? 

I'm still lost on what is missing that vDPA can't build on top of what is
available?

Cheers,
Ashok
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
