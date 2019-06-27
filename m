Return-Path: <SRS0=izKu=U2=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B58CC48BD6
	for <iommu@archiver.kernel.org>; Thu, 27 Jun 2019 15:37:20 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECB4120656
	for <iommu@archiver.kernel.org>; Thu, 27 Jun 2019 15:37:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECB4120656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id A9CB8D3D;
	Thu, 27 Jun 2019 15:37:19 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 676D2B79
	for <iommu@lists.linux-foundation.org>;
	Thu, 27 Jun 2019 15:37:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id CC8E9832
	for <iommu@lists.linux-foundation.org>;
	Thu, 27 Jun 2019 15:37:17 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	27 Jun 2019 08:37:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,424,1557212400"; d="scan'208";a="173170326"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
	by orsmga002.jf.intel.com with ESMTP; 27 Jun 2019 08:37:17 -0700
Date: Thu, 27 Jun 2019 08:40:33 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v4 15/22] iommu/vt-d: Replace Intel specific PASID
	allocator with IOASID
Message-ID: <20190627084033.650dc7ed@jacob-builder>
In-Reply-To: <1cffc7c7-b71b-767a-a35f-d6063dc64b2b@linux.intel.com>
References: <1560087862-57608-1-git-send-email-jacob.jun.pan@linux.intel.com>
	<1560087862-57608-16-git-send-email-jacob.jun.pan@linux.intel.com>
	<1cffc7c7-b71b-767a-a35f-d6063dc64b2b@linux.intel.com>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Raj Ashok <ashok.raj@intel.com>,
	Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
	iommu@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>,
	Alex Williamson <alex.williamson@redhat.com>,
	Andriy Shevchenko <andriy.shevchenko@linux.intel.com>,
	David Woodhouse <dwmw2@infradead.org>
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

On Thu, 27 Jun 2019 09:53:11 +0800
Lu Baolu <baolu.lu@linux.intel.com> wrote:

> Hi Jacob,
> 
> On 6/9/19 9:44 PM, Jacob Pan wrote:
> > Make use of generic IOASID code to manage PASID allocation,
> > free, and lookup. Replace Intel specific code.
> > 
> > Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > ---
> >   drivers/iommu/intel-iommu.c | 11 +++++------
> >   drivers/iommu/intel-pasid.c | 36
> > ------------------------------------ drivers/iommu/intel-svm.c   |
> > 37 +++++++++++++++++++++---------------- 3 files changed, 26
> > insertions(+), 58 deletions(-)
> > 
> > diff --git a/drivers/iommu/intel-iommu.c
> > b/drivers/iommu/intel-iommu.c index 5b84994..39b63fe 100644
> > --- a/drivers/iommu/intel-iommu.c
> > +++ b/drivers/iommu/intel-iommu.c
> > @@ -5167,7 +5167,7 @@ static void auxiliary_unlink_device(struct
> > dmar_domain *domain, domain->auxd_refcnt--;
> >   
> >   	if (!domain->auxd_refcnt && domain->default_pasid > 0)
> > -		intel_pasid_free_id(domain->default_pasid);
> > +		ioasid_free(domain->default_pasid);
> >   }
> >   
> >   static int aux_domain_add_dev(struct dmar_domain *domain,
> > @@ -5185,10 +5185,9 @@ static int aux_domain_add_dev(struct
> > dmar_domain *domain, if (domain->default_pasid <= 0) {
> >   		int pasid;
> >   
> > -		pasid = intel_pasid_alloc_id(domain, PASID_MIN,
> > -
> > pci_max_pasids(to_pci_dev(dev)),
> > -					     GFP_KERNEL);
> > -		if (pasid <= 0) {
> > +		pasid = ioasid_alloc(NULL, PASID_MIN,
> > pci_max_pasids(to_pci_dev(dev)) - 1,
> > +				domain);
> > +		if (pasid == INVALID_IOASID) {
> >   			pr_err("Can't allocate default pasid\n");
> >   			return -ENODEV;
> >   		}
> > @@ -5224,7 +5223,7 @@ static int aux_domain_add_dev(struct
> > dmar_domain *domain, spin_unlock(&iommu->lock);
> >   	spin_unlock_irqrestore(&device_domain_lock, flags);
> >   	if (!domain->auxd_refcnt && domain->default_pasid > 0)
> > -		intel_pasid_free_id(domain->default_pasid);
> > +		ioasid_free(domain->default_pasid);
> >   
> >   	return ret;
> >   }
> > diff --git a/drivers/iommu/intel-pasid.c
> > b/drivers/iommu/intel-pasid.c index 69fddd3..1e25539 100644
> > --- a/drivers/iommu/intel-pasid.c
> > +++ b/drivers/iommu/intel-pasid.c
> > @@ -26,42 +26,6 @@
> >    */
> >   static DEFINE_SPINLOCK(pasid_lock);
> >   u32 intel_pasid_max_id = PASID_MAX;
> > -static DEFINE_IDR(pasid_idr);
> > -
> > -int intel_pasid_alloc_id(void *ptr, int start, int end, gfp_t gfp)
> > -{
> > -	int ret, min, max;
> > -
> > -	min = max_t(int, start, PASID_MIN);
> > -	max = min_t(int, end, intel_pasid_max_id);
> > -
> > -	WARN_ON(in_interrupt());
> > -	idr_preload(gfp);
> > -	spin_lock(&pasid_lock);
> > -	ret = idr_alloc(&pasid_idr, ptr, min, max, GFP_ATOMIC);
> > -	spin_unlock(&pasid_lock);
> > -	idr_preload_end();
> > -
> > -	return ret;
> > -}
> > -
> > -void intel_pasid_free_id(int pasid)
> > -{
> > -	spin_lock(&pasid_lock);
> > -	idr_remove(&pasid_idr, pasid);
> > -	spin_unlock(&pasid_lock);
> > -}
> > -
> > -void *intel_pasid_lookup_id(int pasid)
> > -{
> > -	void *p;
> > -
> > -	spin_lock(&pasid_lock);
> > -	p = idr_find(&pasid_idr, pasid);
> > -	spin_unlock(&pasid_lock);
> > -
> > -	return p;
> > -}
> >   
> >   int vcmd_alloc_pasid(struct intel_iommu *iommu, unsigned int
> > *pasid) {
> > diff --git a/drivers/iommu/intel-svm.c b/drivers/iommu/intel-svm.c
> > index 8f87304..9cbcc1f 100644
> > --- a/drivers/iommu/intel-svm.c
> > +++ b/drivers/iommu/intel-svm.c
> > @@ -25,6 +25,7 @@
> >   #include <linux/dmar.h>
> >   #include <linux/interrupt.h>
> >   #include <linux/mm_types.h>
> > +#include <linux/ioasid.h>
> >   #include <asm/page.h>
> >   
> >   #include "intel-pasid.h"
> > @@ -332,16 +333,15 @@ int intel_svm_bind_mm(struct device *dev, int
> > *pasid, int flags, struct svm_dev_ if (pasid_max >
> > intel_pasid_max_id) pasid_max = intel_pasid_max_id;
> >   
> > -		/* Do not use PASID 0 in caching mode (virtualised
> > IOMMU) */
> > -		ret = intel_pasid_alloc_id(svm,
> > -					   !!cap_caching_mode(iommu->cap),
> > -					   pasid_max - 1,
> > GFP_KERNEL);
> > -		if (ret < 0) {
> > +		/* Do not use PASID 0, reserved for RID to PASID */
> > +		svm->pasid = ioasid_alloc(NULL, PASID_MIN,
> > +					pasid_max - 1, svm);
> > +		if (svm->pasid == INVALID_IOASID) {
> >   			kfree(svm);
> >   			kfree(sdev);
> > +			ret = ENOSPC;
> >   			goto out;
> >   		}
> > -		svm->pasid = ret;
> >   		svm->notifier.ops = &intel_mmuops;
> >   		svm->mm = mm;
> >   		svm->flags = flags;
> > @@ -351,7 +351,7 @@ int intel_svm_bind_mm(struct device *dev, int
> > *pasid, int flags, struct svm_dev_ if (mm) {
> >   			ret =
> > mmu_notifier_register(&svm->notifier, mm); if (ret) {
> > -				intel_pasid_free_id(svm->pasid);
> > +				ioasid_free(svm->pasid);
> >   				kfree(svm);
> >   				kfree(sdev);
> >   				goto out;
> > @@ -367,7 +367,7 @@ int intel_svm_bind_mm(struct device *dev, int
> > *pasid, int flags, struct svm_dev_ if (ret) {
> >   			if (mm)
> >   				mmu_notifier_unregister(&svm->notifier,
> > mm);
> > -			intel_pasid_free_id(svm->pasid);
> > +			ioasid_free(svm->pasid);
> >   			kfree(svm);
> >   			kfree(sdev);
> >   			goto out;
> > @@ -400,7 +400,12 @@ int intel_svm_unbind_mm(struct device *dev,
> > int pasid) if (!iommu)
> >   		goto out;
> >   
> > -	svm = intel_pasid_lookup_id(pasid);
> > +	svm = ioasid_find(NULL, pasid, NULL);
> > +	if (IS_ERR(svm)) {
> > +		ret = PTR_ERR(svm);
> > +		goto out;
> > +	}
> > +
> >   	if (!svm)
> >   		goto out;
> >     
> 
> How about using IS_ERR_OR_NULL() here?
> 
makes sense, same below. thanks!
>  [...]  
> 
> Same here.
> 
>  [...]  
> 
> Ditto.
> 
>  [...]  
> 
> Best regards,
> Baolu

[Jacob Pan]
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
