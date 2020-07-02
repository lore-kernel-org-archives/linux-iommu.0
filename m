Return-Path: <SRS0=8rqH=AN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A34F7C433DF
	for <iommu@archiver.kernel.org>; Thu,  2 Jul 2020 13:37:09 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6EAE42088E
	for <iommu@archiver.kernel.org>; Thu,  2 Jul 2020 13:37:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EAE42088E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 3FFAA8A7F1;
	Thu,  2 Jul 2020 13:37:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id llcesI1AZ59o; Thu,  2 Jul 2020 13:37:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id AF8DF8A7D7;
	Thu,  2 Jul 2020 13:37:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9456BC0888;
	Thu,  2 Jul 2020 13:37:08 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BF775C0733
 for <iommu@lists.linux-foundation.org>; Thu,  2 Jul 2020 13:37:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id AE69188EB1
 for <iommu@lists.linux-foundation.org>; Thu,  2 Jul 2020 13:37:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id N9i_bNTK-l2F for <iommu@lists.linux-foundation.org>;
 Thu,  2 Jul 2020 13:37:06 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 7EAE188A48
 for <iommu@lists.linux-foundation.org>; Thu,  2 Jul 2020 13:37:06 +0000 (UTC)
IronPort-SDR: LiOlKANwkBfibm0T3O2c1FqS/ou1Si/UXmIeWHBGVFNZWaf+LJCcC7UBalJqA9jtWH1uqK4GnR
 AD+JXMBCD53A==
X-IronPort-AV: E=McAfee;i="6000,8403,9669"; a="211937502"
X-IronPort-AV: E=Sophos;i="5.75,304,1589266800"; d="scan'208";a="211937502"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jul 2020 06:37:05 -0700
IronPort-SDR: qD6O/1RKxxZPtysu3PRMimGKQxcacJFbEMoMKBx0VX8iwfD+GHAXRZccM2MSOcex7d8lOcq9OM
 W1NmJMCJHMPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,304,1589266800"; d="scan'208";a="278125977"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
 by orsmga003.jf.intel.com with ESMTP; 02 Jul 2020 06:37:05 -0700
Date: Thu, 2 Jul 2020 06:43:41 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Auger Eric <eric.auger@redhat.com>
Subject: Re: [PATCH v3 6/7] iommu/vt-d: Warn on out-of-range invalidation
 address
Message-ID: <20200702064341.18d513a5@jacob-builder>
In-Reply-To: <7c265689-a23c-021b-27e7-beb3cd667a5f@redhat.com>
References: <1593617636-79385-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1593617636-79385-7-git-send-email-jacob.jun.pan@linux.intel.com>
 <7c265689-a23c-021b-27e7-beb3cd667a5f@redhat.com>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Raj Ashok <ashok.raj@intel.com>,
 LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux-foundation.org,
 David Woodhouse <dwmw2@infradead.org>
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

Hi Eric,

On Thu, 2 Jul 2020 10:47:39 +0200
Auger Eric <eric.auger@redhat.com> wrote:

> Hi,
> 
> On 7/1/20 5:33 PM, Jacob Pan wrote:
> > For guest requested IOTLB invalidation, address and mask are
> > provided as part of the invalidation data. VT-d HW silently ignores
> > any address bits below the mask. SW shall also allow such case but
> > give warning if address does not align with the mask. This patch
> > relax the fault handling from error to warning and proceed with
> > invalidation request with the given mask.  
> What I don't really get is the guest shouldn't do that. Don't we want
> to be more strict in that case and return an error?
> 
My thinking is that the driver should behave the same level of leniency
as the HW. The other concern is that the consequence is severe, if TLB
invalidation failed, we have hang the guest to protect security.

> Thanks
> 
> Eric
> > 
> > Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > ---
> >  drivers/iommu/intel/iommu.c | 7 +++----
> >  1 file changed, 3 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/iommu/intel/iommu.c
> > b/drivers/iommu/intel/iommu.c index 6a0c62c7395c..2e1b53ade784
> > 100644 --- a/drivers/iommu/intel/iommu.c
> > +++ b/drivers/iommu/intel/iommu.c
> > @@ -5439,13 +5439,12 @@ intel_iommu_sva_invalidate(struct
> > iommu_domain *domain, struct device *dev, 
> >  		switch (BIT(cache_type)) {
> >  		case IOMMU_CACHE_INV_TYPE_IOTLB:
> > +			/* HW will ignore LSB bits based on
> > address mask */ if (inv_info->granularity == IOMMU_INV_GRANU_ADDR &&
> >  			    size &&
> >  			    (inv_info->addr_info.addr &
> > ((BIT(VTD_PAGE_SHIFT + size)) - 1))) {
> > -				pr_err_ratelimited("Address out of
> > range, 0x%llx, size order %llu\n",
> > -
> > inv_info->addr_info.addr, size);
> > -				ret = -ERANGE;
> > -				goto out_unlock;
> > +				pr_err_ratelimited("User address
> > not aligned, 0x%llx, size order %llu\n",
> > +
> > inv_info->addr_info.addr, size); }
> >  
> >  			/*
> >   
> 

[Jacob Pan]
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
