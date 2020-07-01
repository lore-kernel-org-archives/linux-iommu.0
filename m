Return-Path: <SRS0=cxdO=AM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D65EBC433DF
	for <iommu@archiver.kernel.org>; Wed,  1 Jul 2020 14:12:49 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A5AD20702
	for <iommu@archiver.kernel.org>; Wed,  1 Jul 2020 14:12:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A5AD20702
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 5C8D78AFCB;
	Wed,  1 Jul 2020 14:12:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IJdlWR0KLaA9; Wed,  1 Jul 2020 14:12:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id AF1158C0AA;
	Wed,  1 Jul 2020 14:12:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9BCD6C0865;
	Wed,  1 Jul 2020 14:12:48 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 26701C0733
 for <iommu@lists.linux-foundation.org>; Wed,  1 Jul 2020 14:12:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 1609F8C0AA
 for <iommu@lists.linux-foundation.org>; Wed,  1 Jul 2020 14:12:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NsyxdTVhU4CH for <iommu@lists.linux-foundation.org>;
 Wed,  1 Jul 2020 14:12:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 5C9898AFCB
 for <iommu@lists.linux-foundation.org>; Wed,  1 Jul 2020 14:12:46 +0000 (UTC)
IronPort-SDR: a6csIr1Yga3cj9oObx+jNcHdpFTrsdxKUhur1AGlVCqVlnpS3n9wTm5tNOi9RBy8HrI1jS3EZY
 VTlgiyxxyfGQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9668"; a="145653499"
X-IronPort-AV: E=Sophos;i="5.75,300,1589266800"; d="scan'208";a="145653499"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Jul 2020 07:12:45 -0700
IronPort-SDR: tw+TjEMnr6PSKKEIZGIwlRnMnY+I1IPteQ9YJ/b+xboSW0wpxSK+AXL5tZVvEIqLGEWC1jcv7/
 mq9WRPL4QW+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,300,1589266800"; d="scan'208";a="455118375"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
 by orsmga005.jf.intel.com with ESMTP; 01 Jul 2020 07:12:45 -0700
Date: Wed, 1 Jul 2020 07:19:20 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH 6/7] iommu/vt-d: Warn on out-of-range invalidation address
Message-ID: <20200701071920.0a08f404@jacob-builder>
In-Reply-To: <f5a2ffda-a243-ed20-63e0-50d784d3af71@linux.intel.com>
References: <1592926996-47914-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1592926996-47914-7-git-send-email-jacob.jun.pan@linux.intel.com>
 <d87d15fd-71d5-6735-74df-583024826ab0@linux.intel.com>
 <20200630103459.6c99c961@jacob-builder>
 <f5a2ffda-a243-ed20-63e0-50d784d3af71@linux.intel.com>
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

On Wed, 1 Jul 2020 09:45:40 +0800
Lu Baolu <baolu.lu@linux.intel.com> wrote:

> Hi Jacob,
> 
> On 7/1/20 1:34 AM, Jacob Pan wrote:
> > On Thu, 25 Jun 2020 18:10:43 +0800
> > Lu Baolu<baolu.lu@linux.intel.com>  wrote:
> >   
> >> Hi,
> >>
> >> On 2020/6/23 23:43, Jacob Pan wrote:  
> >>> For guest requested IOTLB invalidation, address and mask are
> >>> provided as part of the invalidation data. VT-d HW silently
> >>> ignores any address bits below the mask. SW shall also allow such
> >>> case but give warning if address does not align with the mask.
> >>> This patch relax the fault handling from error to warning and
> >>> proceed with invalidation request with the given mask.
> >>>
> >>> Signed-off-by: Jacob Pan<jacob.jun.pan@linux.intel.com>
> >>> ---
> >>>    drivers/iommu/intel/iommu.c | 7 +++----
> >>>    1 file changed, 3 insertions(+), 4 deletions(-)
> >>>
> >>> diff --git a/drivers/iommu/intel/iommu.c
> >>> b/drivers/iommu/intel/iommu.c index 5ea5732d5ec4..50fc62413a35
> >>> 100644 --- a/drivers/iommu/intel/iommu.c
> >>> +++ b/drivers/iommu/intel/iommu.c
> >>> @@ -5439,13 +5439,12 @@ intel_iommu_sva_invalidate(struct
> >>> iommu_domain *domain, struct device *dev,
> >>>    		switch (BIT(cache_type)) {
> >>>    		case IOMMU_CACHE_INV_TYPE_IOTLB:
> >>> +			/* HW will ignore LSB bits based on
> >>> address mask */ if (inv_info->granularity == IOMMU_INV_GRANU_ADDR
> >>> && size &&
> >>>    			    (inv_info->addr_info.addr &
> >>> ((BIT(VTD_PAGE_SHIFT + size)) - 1))) {
> >>> -				pr_err_ratelimited("Address out
> >>> of range, 0x%llx, size order %llu\n",
> >>> -
> >>> inv_info->addr_info.addr, size);
> >>> -				ret = -ERANGE;
> >>> -				goto out_unlock;
> >>> +				WARN_ONCE(1, "Address out of
> >>> range, 0x%llx, size order %llu\n",
> >>> +
> >>> inv_info->addr_info.addr, size);  
> >> I don't think WARN_ONCE() is suitable here. It makes users think
> >> it's a kernel bug. How about pr_warn_ratelimited()?
> >>  
> > I think pr_warn_ratelimited might still be too chatty. There is no
> > functional issues, we just don't to silently ignore it. Perhaps just
> > say:
> > WARN_ONCE(1, "User provided address not page aligned, alignment
> > forced") ?
> >   
> 
> WARN() is normally used for reporting a kernel bug. It dumps kernel
> trace. And the users will report bug through bugzilla.kernel.org.
> 
> In this case, it's actually an unexpected user input, we shouldn't
> treat it as a kernel bug and pr_err_ratelimited() is enough?
> 
Sounds good. I will leave it.

Thanks,

Jacob
> Best regards,
> baolu

[Jacob Pan]
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
