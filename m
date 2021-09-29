Return-Path: <SRS0=Xpq5=OT=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40F1DC433F5
	for <iommu@archiver.kernel.org>; Wed, 29 Sep 2021 22:53:45 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D21A861529
	for <iommu@archiver.kernel.org>; Wed, 29 Sep 2021 22:53:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D21A861529
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A1228607CE;
	Wed, 29 Sep 2021 22:53:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id c0jPIoRLeaHP; Wed, 29 Sep 2021 22:53:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id EC7F0607BF;
	Wed, 29 Sep 2021 22:53:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B8CAAC000F;
	Wed, 29 Sep 2021 22:53:42 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 27C2CC000D
 for <iommu@lists.linux-foundation.org>; Wed, 29 Sep 2021 22:53:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 04A8883FFF
 for <iommu@lists.linux-foundation.org>; Wed, 29 Sep 2021 22:53:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UJc_3mbaISgv for <iommu@lists.linux-foundation.org>;
 Wed, 29 Sep 2021 22:53:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6029C83FFE
 for <iommu@lists.linux-foundation.org>; Wed, 29 Sep 2021 22:53:41 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10122"; a="310604808"
X-IronPort-AV: E=Sophos;i="5.85,334,1624345200"; d="scan'208";a="310604808"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Sep 2021 15:53:40 -0700
X-IronPort-AV: E=Sophos;i="5.85,334,1624345200"; d="scan'208";a="588270949"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
 by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Sep 2021 15:53:40 -0700
Date: Wed, 29 Sep 2021 15:57:20 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [RFC 0/7] Support in-kernel DMA with PASID and SVA
Message-ID: <20210929155720.794b6e65@jacob-builder>
In-Reply-To: <20210929193953.GX964074@nvidia.com>
References: <1632256181-36071-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <20210929123437.721991dc@jacob-builder>
 <20210929193953.GX964074@nvidia.com>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Tony Luck <tony.luck@intel.com>,
 Dave Jiang <dave.jiang@intel.com>, Raj Ashok <ashok.raj@intel.com>, "Kumar, 
 Sanjay K" <sanjay.k.kumar@intel.com>, LKML <linux-kernel@vger.kernel.org>,
 Christoph Hellwig <hch@infradead.org>, iommu@lists.linux-foundation.org,
 mike.campin@intel.com, Thomas Gleixner <tglx@linutronix.de>
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

On Wed, 29 Sep 2021 16:39:53 -0300, Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Wed, Sep 29, 2021 at 12:37:19PM -0700, Jacob Pan wrote:
>  
> > For #2, it seems we can store the kernel PASID in struct device. This
> > will preserve the DMA API interface while making it PASID capable.
> > Essentially, each PASID capable device would have two special global
> > PASIDs: 
> > 	- PASID 0 for DMA request w/o PASID, aka RID2PASID
> > 	- PASID 1 (randomly selected) for in-kernel DMA request w/
> > PASID  
> 
> This seems reasonable, I had the same thought. Basically just have the
> driver issue some trivial call:
>   pci_enable_pasid_dma(pdev, &pasid)
That would work, but I guess it needs to be an iommu_ call instead of pci_?

Or, it can be done by the platform IOMMU code where system PASID is
automatically enabled for PASID capable devices during boot and stored in
struct device. Device drivers can retrieve the PASID from struct device.

I think your suggestion is more precise, in case the driver does not want
to do DMA w/ PASID, we can do less IOTLB flush (PASID 0 only).

> And then DMA tagged with the PASID will be handled equivilant to
> untagged DMA. Basically PASID and no PASID point to the exact same IO
> page table and the DMA API manipulates that single page table.
> 
> Having multiple RID's pointing at the same IO page table is something
> we expect iommufd to require so the whole thing should ideally fall
> out naturally.
That would be the equivalent of attaching multiple devices to the same
IOMMU domain. right?

> Jason


Thanks,

Jacob
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
