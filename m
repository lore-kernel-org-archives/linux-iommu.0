Return-Path: <SRS0=tLNU=5F=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2A52C4332D
	for <iommu@archiver.kernel.org>; Fri, 20 Mar 2020 16:15:11 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B420820724
	for <iommu@archiver.kernel.org>; Fri, 20 Mar 2020 16:15:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B420820724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 9C14F88B83;
	Fri, 20 Mar 2020 16:15:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qqBRwZ9rMPGQ; Fri, 20 Mar 2020 16:15:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 0794688AEE;
	Fri, 20 Mar 2020 16:15:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E0428C1D88;
	Fri, 20 Mar 2020 16:15:08 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9EA2CC1830
 for <iommu@lists.linux-foundation.org>; Fri, 20 Mar 2020 16:15:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 9B267204FF
 for <iommu@lists.linux-foundation.org>; Fri, 20 Mar 2020 16:15:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id upLjC1sQtucx for <iommu@lists.linux-foundation.org>;
 Fri, 20 Mar 2020 16:15:06 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by silver.osuosl.org (Postfix) with ESMTPS id C03BB22622
 for <iommu@lists.linux-foundation.org>; Fri, 20 Mar 2020 16:15:06 +0000 (UTC)
IronPort-SDR: VcoJzZw19FG1pMtmDB4lt9I0qwZA5l9FDGXMjaXQsItCALXmYeT4EMglNbPN0O+q8rU8iMrsE9
 crLUU78hx08w==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Mar 2020 09:15:06 -0700
IronPort-SDR: nfbF9FQqKHkQ9x3+7AJIAWSbRldf4humNn2N1DChKht7YMxC+rThaYhyh30bvSaeO6vZ5Pi7Qi
 tg2lPKnv9Zew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,285,1580803200"; d="scan'208";a="418762631"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
 by orsmga005.jf.intel.com with ESMTP; 20 Mar 2020 09:15:06 -0700
Date: Fri, 20 Mar 2020 09:20:47 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH 1/3] iommu/vt-d: Remove redundant IOTLB flush
Message-ID: <20200320092047.4a4cf551@jacob-builder>
In-Reply-To: <26ab1917-f087-aafa-e861-6a2478000a6f@linux.intel.com>
References: <1584678751-43169-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1584678751-43169-2-git-send-email-jacob.jun.pan@linux.intel.com>
 <26ab1917-f087-aafa-e861-6a2478000a6f@linux.intel.com>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Cc: Raj Ashok <ashok.raj@intel.com>, LKML <linux-kernel@vger.kernel.org>,
 iommu@lists.linux-foundation.org, David Woodhouse <dwmw2@infradead.org>
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

On Fri, 20 Mar 2020 21:45:26 +0800
Lu Baolu <baolu.lu@linux.intel.com> wrote:

> On 2020/3/20 12:32, Jacob Pan wrote:
> > IOTLB flush already included in the PASID tear down process. There
> > is no need to flush again.  
> 
> It seems that intel_pasid_tear_down_entry() doesn't flush the pasid
> based device TLB?
> 
I saw this code in intel_pasid_tear_down_entry(). Isn't the last line
flush the devtlb? Not in guest of course since the passdown tlb flush
is inclusive.

	pasid_cache_invalidation_with_pasid(iommu, did, pasid);
	iotlb_invalidation_with_pasid(iommu, did, pasid);

	/* Device IOTLB doesn't need to be flushed in caching mode. */
	if (!cap_caching_mode(iommu->cap))
		devtlb_invalidation_with_pasid(iommu, dev, pasid);

> Best regards,
> baolu
> 
> > 
> > Cc: Lu Baolu <baolu.lu@linux.intel.com>
> > Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > ---
> >   drivers/iommu/intel-svm.c | 6 ++----
> >   1 file changed, 2 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/iommu/intel-svm.c b/drivers/iommu/intel-svm.c
> > index 8f42d717d8d7..1483f1845762 100644
> > --- a/drivers/iommu/intel-svm.c
> > +++ b/drivers/iommu/intel-svm.c
> > @@ -268,10 +268,9 @@ static void intel_mm_release(struct
> > mmu_notifier *mn, struct mm_struct *mm)
> >   	 * *has* to handle gracefully without affecting other
> > processes. */
> >   	rcu_read_lock();
> > -	list_for_each_entry_rcu(sdev, &svm->devs, list) {
> > +	list_for_each_entry_rcu(sdev, &svm->devs, list)
> >   		intel_pasid_tear_down_entry(svm->iommu,
> > sdev->dev, svm->pasid);
> > -		intel_flush_svm_range_dev(svm, sdev, 0, -1, 0);
> > -	}
> > +
> >   	rcu_read_unlock();
> >   
> >   }
> > @@ -731,7 +730,6 @@ int intel_svm_unbind_mm(struct device *dev, int
> > pasid)
> >   			 * large and has to be physically
> > contiguous. So it's
> >   			 * hard to be as defensive as we might
> > like. */ intel_pasid_tear_down_entry(iommu, dev, svm->pasid);
> > -			intel_flush_svm_range_dev(svm, sdev, 0,
> > -1, 0); kfree_rcu(sdev, rcu);
> >   
> >   			if (list_empty(&svm->devs)) {
> >   

[Jacob Pan]
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
