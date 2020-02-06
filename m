Return-Path: <SRS0=jQQH=32=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BBABC33CAC
	for <iommu@archiver.kernel.org>; Thu,  6 Feb 2020 18:07:40 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E7F6217F4
	for <iommu@archiver.kernel.org>; Thu,  6 Feb 2020 18:07:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E7F6217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 577E6860FC;
	Thu,  6 Feb 2020 18:07:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jpgSn-kb8oyR; Thu,  6 Feb 2020 18:07:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id E6532860C1;
	Thu,  6 Feb 2020 18:07:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CFDCDC0881;
	Thu,  6 Feb 2020 18:07:38 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1C2B4C013E
 for <iommu@lists.linux-foundation.org>; Thu,  6 Feb 2020 18:07:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 0A735860C1
 for <iommu@lists.linux-foundation.org>; Thu,  6 Feb 2020 18:07:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id S8DJzBpUwMBx for <iommu@lists.linux-foundation.org>;
 Thu,  6 Feb 2020 18:07:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 2B30785FC6
 for <iommu@lists.linux-foundation.org>; Thu,  6 Feb 2020 18:07:36 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 06 Feb 2020 10:07:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,410,1574150400"; d="scan'208";a="379143775"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
 by orsmga004.jf.intel.com with ESMTP; 06 Feb 2020 10:07:35 -0800
Date: Thu, 6 Feb 2020 10:12:53 -0800
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: "Liu, Yi L" <yi.l.liu@intel.com>
Subject: Re: [RFC v3 1/8] vfio: Add VFIO_IOMMU_PASID_REQUEST(alloc/free)
Message-ID: <20200206101253.7fb43e07@jacob-builder>
In-Reply-To: <A2975661238FB949B60364EF0F2C25743A1993E8@SHSMSX104.ccr.corp.intel.com>
References: <1580299912-86084-1-git-send-email-yi.l.liu@intel.com>
 <1580299912-86084-2-git-send-email-yi.l.liu@intel.com>
 <20200129165540.335774d5@w520.home>
 <A2975661238FB949B60364EF0F2C25743A1993E8@SHSMSX104.ccr.corp.intel.com>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Cc: "Tian, Kevin" <kevin.tian@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "jean-philippe.brucker@arm.com" <jean-philippe.brucker@arm.com>, "Tian,
 Jun J" <jun.j.tian@intel.com>, "Sun, Yi Y" <yi.y.sun@intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
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

Hi Alex,

On Fri, 31 Jan 2020 12:41:06 +0000
"Liu, Yi L" <yi.l.liu@intel.com> wrote:

> > > +static int vfio_iommu_type1_pasid_free(struct vfio_iommu *iommu,
> > > +				       unsigned int pasid)
> > > +{
> > > +	struct vfio_mm *vmm = iommu->vmm;
> > > +	int ret = 0;
> > > +
> > > +	mutex_lock(&iommu->lock);
> > > +	if (!IS_IOMMU_CAP_DOMAIN_IN_CONTAINER(iommu)) {  
> > 
> > But we could have been IOMMU backed when the pasid was allocated,
> > did we just leak something?  In fact, I didn't spot anything in
> > this series that handles a container with pasids allocated losing
> > iommu backing. I'd think we want to release all pasids when that
> > happens since permission for the user to hold pasids goes along
> > with having an iommu backed device.  
> 
> oh, yes. If a container lose iommu backend, then needs to reclaim the
> allocated PASIDs. right? I'll add it. :-)
> 
> > Also, do we want _free() paths that can fail?  
> 
> I remember we discussed if a _free() path can fail, I think we agreed
> to let _free() path always success. :-)

Just to add some details. We introduced IOASID notifier such that when
VFIO frees a PASID, consumers such as IOMMU, can do the cleanup
therefore ensure free always succeeds.
https://www.spinics.net/lists/kernel/msg3349928.html
https://www.spinics.net/lists/kernel/msg3349930.html
This was not in my v9 set as I was considering some race conditions
w.r.t. registering notifier, gets notifications, and free call. I will
post it in v10.

Thanks,

Jacob
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
