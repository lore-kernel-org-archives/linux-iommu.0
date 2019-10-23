Return-Path: <SRS0=/ROq=YQ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6620CA9EB9
	for <iommu@archiver.kernel.org>; Wed, 23 Oct 2019 00:59:03 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7EA24214B2
	for <iommu@archiver.kernel.org>; Wed, 23 Oct 2019 00:59:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EA24214B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 3614DB62;
	Wed, 23 Oct 2019 00:59:03 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 8DDBCAD0
	for <iommu@lists.linux-foundation.org>;
	Wed, 23 Oct 2019 00:59:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id D020B87B
	for <iommu@lists.linux-foundation.org>;
	Wed, 23 Oct 2019 00:59:00 +0000 (UTC)
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
	by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	22 Oct 2019 17:59:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,218,1569308400"; d="scan'208";a="399226426"
Received: from otc-nc-03.jf.intel.com (HELO otc-nc-03) ([10.54.39.145])
	by fmsmga006.fm.intel.com with ESMTP; 22 Oct 2019 17:58:59 -0700
Date: Tue, 22 Oct 2019 17:58:59 -0700
From: "Raj, Ashok" <ashok.raj@intel.com>
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [PATCH v6 03/10] iommu/vt-d: Replace Intel specific PASID
	allocator with IOASID
Message-ID: <20191023005859.GD100970@otc-nc-03>
References: <1571788403-42095-1-git-send-email-jacob.jun.pan@linux.intel.com>
	<1571788403-42095-4-git-send-email-jacob.jun.pan@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1571788403-42095-4-git-send-email-jacob.jun.pan@linux.intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Ashok Raj <ashok.raj@intel.com>,
	David Woodhouse <dwmw2@infradead.org>, iommu@lists.linux-foundation.org,
	LKML <linux-kernel@vger.kernel.org>,
	Alex Williamson <alex.williamson@redhat.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.com>,
	Jonathan Cameron <jic23@kernel.org>
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

On Tue, Oct 22, 2019 at 04:53:16PM -0700, Jacob Pan wrote:
> Make use of generic IOASID code to manage PASID allocation,
> free, and lookup. Replace Intel specific code.
> 
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> ---
>  drivers/iommu/intel-iommu.c | 12 ++++++------
>  drivers/iommu/intel-pasid.c | 36 ------------------------------------
>  drivers/iommu/intel-svm.c   | 37 +++++++++++++++++++++----------------
>  3 files changed, 27 insertions(+), 58 deletions(-)
> 
> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> index 3aff0141c522..72febcf2c48f 100644
> --- a/drivers/iommu/intel-iommu.c
> +++ b/drivers/iommu/intel-iommu.c
> @@ -5311,7 +5311,7 @@ static void auxiliary_unlink_device(struct dmar_domain *domain,
>  	domain->auxd_refcnt--;
>  
>  	if (!domain->auxd_refcnt && domain->default_pasid > 0)
> -		intel_pasid_free_id(domain->default_pasid);
> +		ioasid_free(domain->default_pasid);

if the domain is gauranteed to be torn down, its ok.. but otherwise
do you need to clear domain->default_pasid to avoid accidental reference
in some other code path?

>  }
>  
>  static int aux_domain_add_dev(struct dmar_domain *domain,
> @@ -5329,10 +5329,10 @@ static int aux_domain_add_dev(struct dmar_domain *domain,
>  	if (domain->default_pasid <= 0) {
>  		int pasid;
>  
> -		pasid = intel_pasid_alloc_id(domain, PASID_MIN,
> -					     pci_max_pasids(to_pci_dev(dev)),
> -					     GFP_KERNEL);
> -		if (pasid <= 0) {
> +		/* No private data needed for the default pasid */
> +		pasid = ioasid_alloc(NULL, PASID_MIN, pci_max_pasids(to_pci_dev(dev)) - 1,

If we ensure IOMMU max-pasid is full 20bit width, its good. In a vIOMMU
if iommu max pasid is restricted for some kind of partitioning in future
you want to consider limiting to no more than what's provisioned in the vIOMMU 
right?


> +				NULL);
> +		if (pasid == INVALID_IOASID) {
>  			pr_err("Can't allocate default pasid\n");
>  			return -ENODEV;
>  		}
> @@ -5368,7 +5368,7 @@ static int aux_domain_add_dev(struct dmar_domain *domain,
>  	spin_unlock(&iommu->lock);
>  	spin_unlock_irqrestore(&device_domain_lock, flags);
>  	if (!domain->auxd_refcnt && domain->default_pasid > 0)
> -		intel_pasid_free_id(domain->default_pasid);
> +		ioasid_free(domain->default_pasid);
>  
>  	return ret;
>  }
> diff --git a/drivers/iommu/intel-pasid.c b/drivers/iommu/intel-pasid.c
> index 76bcbb21e112..c0d1f28d3412 100644
> --- a/drivers/iommu/intel-pasid.c
> +++ b/drivers/iommu/intel-pasid.c
> @@ -26,42 +26,6 @@
>   */
>  static DEFINE_SPINLOCK(pasid_lock);
>  u32 intel_pasid_max_id = PASID_MAX;
> -static DEFINE_IDR(pasid_idr);
> -
> -int intel_pasid_alloc_id(void *ptr, int start, int end, gfp_t gfp)
> -{
> -	int ret, min, max;
> -
> -	min = max_t(int, start, PASID_MIN);
> -	max = min_t(int, end, intel_pasid_max_id);
> -
> -	WARN_ON(in_interrupt());
> -	idr_preload(gfp);
> -	spin_lock(&pasid_lock);
> -	ret = idr_alloc(&pasid_idr, ptr, min, max, GFP_ATOMIC);
> -	spin_unlock(&pasid_lock);
> -	idr_preload_end();
> -
> -	return ret;
> -}
> -
> -void intel_pasid_free_id(int pasid)
> -{
> -	spin_lock(&pasid_lock);
> -	idr_remove(&pasid_idr, pasid);
> -	spin_unlock(&pasid_lock);
> -}
> -
> -void *intel_pasid_lookup_id(int pasid)
> -{
> -	void *p;
> -
> -	spin_lock(&pasid_lock);
> -	p = idr_find(&pasid_idr, pasid);
> -	spin_unlock(&pasid_lock);
> -
> -	return p;
> -}
>  
>  static int check_vcmd_pasid(struct intel_iommu *iommu)
>  {
> diff --git a/drivers/iommu/intel-svm.c b/drivers/iommu/intel-svm.c
> index 9b159132405d..5aef5b7bf561 100644
> --- a/drivers/iommu/intel-svm.c
> +++ b/drivers/iommu/intel-svm.c
> @@ -17,6 +17,7 @@
>  #include <linux/dmar.h>
>  #include <linux/interrupt.h>
>  #include <linux/mm_types.h>
> +#include <linux/ioasid.h>
>  #include <asm/page.h>
>  
>  #include "intel-pasid.h"
> @@ -318,16 +319,15 @@ int intel_svm_bind_mm(struct device *dev, int *pasid, int flags, struct svm_dev_
>  		if (pasid_max > intel_pasid_max_id)
>  			pasid_max = intel_pasid_max_id;
>  
> -		/* Do not use PASID 0 in caching mode (virtualised IOMMU) */
> -		ret = intel_pasid_alloc_id(svm,
> -					   !!cap_caching_mode(iommu->cap),
> -					   pasid_max - 1, GFP_KERNEL);
> -		if (ret < 0) {
> +		/* Do not use PASID 0, reserved for RID to PASID */
> +		svm->pasid = ioasid_alloc(NULL, PASID_MIN,
> +					pasid_max - 1, svm);
> +		if (svm->pasid == INVALID_IOASID) {
>  			kfree(svm);
>  			kfree(sdev);
> +			ret = ENOSPC;
>  			goto out;
>  		}
> -		svm->pasid = ret;
>  		svm->notifier.ops = &intel_mmuops;
>  		svm->mm = mm;
>  		svm->flags = flags;
> @@ -337,7 +337,7 @@ int intel_svm_bind_mm(struct device *dev, int *pasid, int flags, struct svm_dev_
>  		if (mm) {
>  			ret = mmu_notifier_register(&svm->notifier, mm);
>  			if (ret) {
> -				intel_pasid_free_id(svm->pasid);
> +				ioasid_free(svm->pasid);
>  				kfree(svm);
>  				kfree(sdev);
>  				goto out;
> @@ -353,7 +353,7 @@ int intel_svm_bind_mm(struct device *dev, int *pasid, int flags, struct svm_dev_
>  		if (ret) {
>  			if (mm)
>  				mmu_notifier_unregister(&svm->notifier, mm);
> -			intel_pasid_free_id(svm->pasid);
> +			ioasid_free(svm->pasid);
>  			kfree(svm);
>  			kfree(sdev);
>  			goto out;
> @@ -401,7 +401,12 @@ int intel_svm_unbind_mm(struct device *dev, int pasid)
>  	if (!iommu)
>  		goto out;
>  
> -	svm = intel_pasid_lookup_id(pasid);
> +	svm = ioasid_find(NULL, pasid, NULL);
> +	if (IS_ERR(svm)) {
> +		ret = PTR_ERR(svm);
> +		goto out;
> +	}
> +
>  	if (!svm)
>  		goto out;
>  
> @@ -423,7 +428,7 @@ int intel_svm_unbind_mm(struct device *dev, int pasid)
>  				kfree_rcu(sdev, rcu);
>  
>  				if (list_empty(&svm->devs)) {
> -					intel_pasid_free_id(svm->pasid);
> +					ioasid_free(svm->pasid);
>  					if (svm->mm)
>  						mmu_notifier_unregister(&svm->notifier, svm->mm);
>  
> @@ -458,10 +463,11 @@ int intel_svm_is_pasid_valid(struct device *dev, int pasid)
>  	if (!iommu)
>  		goto out;
>  
> -	svm = intel_pasid_lookup_id(pasid);
> -	if (!svm)
> +	svm = ioasid_find(NULL, pasid, NULL);
> +	if (IS_ERR(svm)) {
> +		ret = PTR_ERR(svm);
>  		goto out;
> -
> +	}
>  	/* init_mm is used in this case */
>  	if (!svm->mm)
>  		ret = 1;
> @@ -568,13 +574,12 @@ static irqreturn_t prq_event_thread(int irq, void *d)
>  
>  		if (!svm || svm->pasid != req->pasid) {
>  			rcu_read_lock();
> -			svm = intel_pasid_lookup_id(req->pasid);
> +			svm = ioasid_find(NULL, req->pasid, NULL);
>  			/* It *can't* go away, because the driver is not permitted
>  			 * to unbind the mm while any page faults are outstanding.
>  			 * So we only need RCU to protect the internal idr code. */
>  			rcu_read_unlock();
> -
> -			if (!svm) {
> +			if (IS_ERR(svm) || !svm) {
>  				pr_err("%s: Page request for invalid PASID %d: %08llx %08llx\n",
>  				       iommu->name, req->pasid, ((unsigned long long *)req)[0],
>  				       ((unsigned long long *)req)[1]);
> -- 
> 2.7.4
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
