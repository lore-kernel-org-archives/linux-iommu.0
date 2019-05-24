Return-Path: <SRS0=CTmu=TY=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57332C282E1
	for <iommu@archiver.kernel.org>; Fri, 24 May 2019 17:57:10 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32E672133D
	for <iommu@archiver.kernel.org>; Fri, 24 May 2019 17:57:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32E672133D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id E21851064;
	Fri, 24 May 2019 17:57:09 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 7BEC11061
	for <iommu@lists.linux-foundation.org>;
	Fri, 24 May 2019 17:57:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id F34B084F
	for <iommu@lists.linux-foundation.org>;
	Fri, 24 May 2019 17:57:07 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	24 May 2019 10:57:07 -0700
X-ExtLoop1: 1
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
	by orsmga002.jf.intel.com with ESMTP; 24 May 2019 10:57:07 -0700
Date: Fri, 24 May 2019 11:00:05 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH 3/4] iommu: Introduce device fault report API
Message-ID: <20190524110005.55c3eade@jacob-builder>
In-Reply-To: <e56244fd-86fd-1fc9-17f7-d00179d586ac@arm.com>
References: <20190523180613.55049-1-jean-philippe.brucker@arm.com>
	<20190523180613.55049-4-jean-philippe.brucker@arm.com>
	<e56244fd-86fd-1fc9-17f7-d00179d586ac@arm.com>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Cc: yi.l.liu@linux.intel.com, ashok.raj@intel.com,
	Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
	iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
	alex.williamson@redhat.com
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

On Thu, 23 May 2019 19:56:54 +0100
Robin Murphy <robin.murphy@arm.com> wrote:

> On 23/05/2019 19:06, Jean-Philippe Brucker wrote:
> > From: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > 
> > Traditionally, device specific faults are detected and handled
> > within their own device drivers. When IOMMU is enabled, faults such
> > as DMA related transactions are detected by IOMMU. There is no
> > generic reporting mechanism to report faults back to the in-kernel
> > device driver or the guest OS in case of assigned devices.
> > 
> > This patch introduces a registration API for device specific fault
> > handlers. This differs from the existing iommu_set_fault_handler/
> > report_iommu_fault infrastructures in several ways:
> > - it allows to report more sophisticated fault events (both
> >    unrecoverable faults and page request faults) due to the nature
> >    of the iommu_fault struct
> > - it is device specific and not domain specific.
> > 
> > The current iommu_report_device_fault() implementation only handles
> > the "shoot and forget" unrecoverable fault case. Handling of page
> > request faults or stalled faults will come later.
> > 
> > Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > Signed-off-by: Ashok Raj <ashok.raj@intel.com>
> > Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
> > Signed-off-by: Eric Auger <eric.auger@redhat.com>
> > ---
> >   drivers/iommu/iommu.c | 127
> > ++++++++++++++++++++++++++++++++++++++++++ include/linux/iommu.h |
> > 29 ++++++++++ 2 files changed, 156 insertions(+)
> > 
> > diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> > index 67ee6623f9b2..d546f7baa0d4 100644
> > --- a/drivers/iommu/iommu.c
> > +++ b/drivers/iommu/iommu.c
> > @@ -644,6 +644,13 @@ int iommu_group_add_device(struct iommu_group
> > *group, struct device *dev) goto err_free_name;
> >   	}
> >   
> > +	dev->iommu_param = kzalloc(sizeof(*dev->iommu_param),
> > GFP_KERNEL);
> > +	if (!dev->iommu_param) {
> > +		ret = -ENOMEM;
> > +		goto err_free_name;
> > +	}
> > +	mutex_init(&dev->iommu_param->lock);
> > +  
> 
> Note that this gets a bit tricky when we come to move to move the 
> fwspec/ops/etc. into iommu_param, since that data can have a longer 
> lifespan than the group association. I'd suggest moving this
> management out to the iommu_{probe,release}_device() level from the
> start, but maybe we're happy to come back and change things later as
> necessary.
> 
Agreed, I can't think of any downside of moving it earlier.
> Robin.
> 
>  [...]  
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu

[Jacob Pan]
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
