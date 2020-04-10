Return-Path: <SRS0=Ithz=52=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 723B6C2BA2B
	for <iommu@archiver.kernel.org>; Fri, 10 Apr 2020 15:37:45 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4262C20857
	for <iommu@archiver.kernel.org>; Fri, 10 Apr 2020 15:37:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4262C20857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 1B37A86CA1;
	Fri, 10 Apr 2020 15:37:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id T5aX23eVDAuf; Fri, 10 Apr 2020 15:37:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id EBB5084DFF;
	Fri, 10 Apr 2020 15:37:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DDAF3C089F;
	Fri, 10 Apr 2020 15:37:42 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 08BDDC0177
 for <iommu@lists.linux-foundation.org>; Fri, 10 Apr 2020 15:37:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id EBC0F88189
 for <iommu@lists.linux-foundation.org>; Fri, 10 Apr 2020 15:37:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id EbkKmwnL+M9b for <iommu@lists.linux-foundation.org>;
 Fri, 10 Apr 2020 15:37:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 4333888177
 for <iommu@lists.linux-foundation.org>; Fri, 10 Apr 2020 15:37:41 +0000 (UTC)
IronPort-SDR: V9p2RpnBXMMfgdy4k5APeBL8aG8AVwXkkrx2lXxRjx0MnQehzaIDr1J+OCDJhjrr/mre2KY6f7
 EVw5gzGT7aww==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Apr 2020 08:37:39 -0700
IronPort-SDR: J6Dax/bXvKp8e/PrJgA2I2XzuLfvfINEOIs3cyvbW3ArQHG7+oGiWVR519yfHikfr0irB+EU8k
 0HEG6rozXItQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,367,1580803200"; d="scan'208";a="252229219"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
 by orsmga003.jf.intel.com with ESMTP; 10 Apr 2020 08:37:40 -0700
Date: Fri, 10 Apr 2020 08:43:32 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: Re: [PATCH 08/10] iommu/ioasid: Introduce notifier APIs
Message-ID: <20200410084332.6a35a8ca@jacob-builder>
In-Reply-To: <20200401140006.GI882512@myrica>
References: <1585158931-1825-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1585158931-1825-9-git-send-email-jacob.jun.pan@linux.intel.com>
 <20200401140006.GI882512@myrica>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Raj Ashok <ashok.raj@intel.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux-foundation.org,
 Alex Williamson <alex.williamson@redhat.com>,
 David Woodhouse <dwmw2@infradead.org>, Jonathan Cameron <jic23@kernel.org>
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

On Wed, 1 Apr 2020 16:00:06 +0200
Jean-Philippe Brucker <jean-philippe@linaro.org> wrote:

> On Wed, Mar 25, 2020 at 10:55:29AM -0700, Jacob Pan wrote:
> > IOASID users fit into the publisher-subscriber pattern, a system
> > wide blocking notifier chain can be used to inform subscribers of
> > state changes. Notifier mechanism also abstracts publisher from
> > knowing the private context each subcriber may have.
> > 
> > This patch adds APIs and a global notifier chain, a further
> > optimization might be per set notifier for ioasid_set aware users.
> > 
> > Usage example:
> > KVM register notifier block such that it can keep its guest-host
> > PASID translation table in sync with any IOASID updates.  
> 
> When you talk about KVM, is it for
> 
>   [PATCH 0/7] x86: tag application address space for devices
> 
> or something else as well? (I don't see mentions of KVM in that
> series)
> 
Yes, related to this set. This is set is for native ENQCMD support.
VMCS use of IOASID notifier is for the guest SVA + ENQCMD.
We need to maintain a G-H PASID translation in VMCS PASID translation
table. When guest binds a GPASID to a host PASID, this translation
table can be updated such that subsequent ENQCMD in the guest can
resolve to a host PASID.

CH 7.3.1 of DSA spec.
https://software.intel.com/sites/default/files/341204-intel-data-streaming-accelerator-spec.pdf 
> > 
> > VFIO publish IOASID change by performing alloc/free, bind/unbind
> > operations.  
> 
> I was rather seeing IOASID as the end of the VFIO-IOMMU-IOASID chain,
> putting it in the middle complicates locking. If you only need to FREE
> notifier for this calse, maybe VFIO could talk directly to the IOMMU
> driver before freeing an IOASID?  gpasid_unbind() should already
> clear the PASID contexts, no?
> 
Yes, VFIO can track all the PASIDs and make sure they do unbind before
free. But that might be more complicated in VFIO, whereas here, when a
guest exits, VFIO can just free the entire IOASID set, IOASID will
notify IOMMU and do all the cleanup.

For maintaining VMCS pasid translation table, KVM still need to know
bind/unbind in addition to free events.

In addition, we also have VDCM (virtual device composition module) that
needs to perform G-H PASID translation and sanity check. VDCM needs the
free event only. This is also in the DSA spec above. The use is that
when the guest programs a GPASID into a virtual device, VDCM (similar
to SRIOV PDEV driver) needs to intercept (via vfio mdev) and translate
GPASID to HPASID.

> Thanks,
> Jean
> 
> > IOMMU driver gets notified when IOASID is freed by VFIO or core mm
> > code such that PASID context can be cleaned up.
> > 
> > Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
> > Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>  

[Jacob Pan]
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
