Return-Path: <SRS0=TfAO=UR=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C68CCC31E5E
	for <iommu@archiver.kernel.org>; Tue, 18 Jun 2019 15:57:34 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C79520873
	for <iommu@archiver.kernel.org>; Tue, 18 Jun 2019 15:57:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C79520873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 6B89BC6F;
	Tue, 18 Jun 2019 15:57:34 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id CA0FAC5C
	for <iommu@lists.linux-foundation.org>;
	Tue, 18 Jun 2019 15:57:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from huawei.com (szxga07-in.huawei.com [45.249.212.35])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 68F9CE6
	for <iommu@lists.linux-foundation.org>;
	Tue, 18 Jun 2019 15:57:31 +0000 (UTC)
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
	by Forcepoint Email with ESMTP id AD07FDD4A694AB0CBA8A;
	Tue, 18 Jun 2019 23:57:26 +0800 (CST)
Received: from localhost (10.202.226.61) by DGGEMS410-HUB.china.huawei.com
	(10.3.19.210) with Microsoft SMTP Server id 14.3.439.0; Tue, 18 Jun 2019
	23:57:21 +0800
Date: Tue, 18 Jun 2019 16:57:09 +0100
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [PATCH v4 15/22] iommu/vt-d: Replace Intel specific PASID
	allocator with IOASID
Message-ID: <20190618165709.00005dbf@huawei.com>
In-Reply-To: <1560087862-57608-16-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1560087862-57608-1-git-send-email-jacob.jun.pan@linux.intel.com>
	<1560087862-57608-16-git-send-email-jacob.jun.pan@linux.intel.com>
Organization: Huawei
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
X-Originating-IP: [10.202.226.61]
X-CFilter-Loop: Reflected
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

On Sun, 9 Jun 2019 06:44:15 -0700
Jacob Pan <jacob.jun.pan@linux.intel.com> wrote:

> Make use of generic IOASID code to manage PASID allocation,
> free, and lookup. Replace Intel specific code.
> 
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
Hi Jacob,

One question inline.

Jonathan

> ---
>  drivers/iommu/intel-iommu.c | 11 +++++------
>  drivers/iommu/intel-pasid.c | 36 ------------------------------------
>  drivers/iommu/intel-svm.c   | 37 +++++++++++++++++++++----------------
>  3 files changed, 26 insertions(+), 58 deletions(-)
> 
> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> index 5b84994..39b63fe 100644
> --- a/drivers/iommu/intel-iommu.c
> +++ b/drivers/iommu/intel-iommu.c
> @@ -5167,7 +5167,7 @@ static void auxiliary_unlink_device(struct dmar_domain *domain,
>  	domain->auxd_refcnt--;
>  
>  	if (!domain->auxd_refcnt && domain->default_pasid > 0)
> -		intel_pasid_free_id(domain->default_pasid);
> +		ioasid_free(domain->default_pasid);
>  }
>  
>  static int aux_domain_add_dev(struct dmar_domain *domain,
> @@ -5185,10 +5185,9 @@ static int aux_domain_add_dev(struct dmar_domain *domain,
>  	if (domain->default_pasid <= 0) {
>  		int pasid;
>  
> -		pasid = intel_pasid_alloc_id(domain, PASID_MIN,
> -					     pci_max_pasids(to_pci_dev(dev)),
> -					     GFP_KERNEL);
> -		if (pasid <= 0) {
> +		pasid = ioasid_alloc(NULL, PASID_MIN, pci_max_pasids(to_pci_dev(dev)) - 1,
> +				domain);

Is there any point in passing the domain in as the private pointer here?
I can't immediately see anywhere it is read back?

It is also rather confusing as the same driver stashes two different types of data
in the same xarray.

> +		if (pasid == INVALID_IOASID) {
>  			pr_err("Can't allocate default pasid\n");
>  			return -ENODEV;
>  		}
> @@ -5224,7 +5223,7 @@ static int aux_domain_add_dev(struct dmar_domain *domain,
>  	spin_unlock(&iommu->lock);
>  	spin_unlock_irqrestore(&device_domain_lock, flags);
>  	if (!domain->auxd_refcnt && domain->default_pasid > 0)
> -		intel_pasid_free_id(domain->default_pasid);
> +		ioasid_free(domain->default_pasid);
>  
>  	return ret;
>  }
> diff --git a/drivers/iommu/intel-pasid.c b/drivers/iommu/intel-pasid.c
> index 69fddd3..1e25539 100644
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
>  int vcmd_alloc_pasid(struct intel_iommu *iommu, unsigned int *pasid)
>  {
> diff --git a/drivers/iommu/intel-svm.c b/drivers/iommu/intel-svm.c
> index 8f87304..9cbcc1f 100644
> --- a/drivers/iommu/intel-svm.c
> +++ b/drivers/iommu/intel-svm.c
> @@ -25,6 +25,7 @@
>  #include <linux/dmar.h>
>  #include <linux/interrupt.h>
>  #include <linux/mm_types.h>
> +#include <linux/ioasid.h>
>  #include <asm/page.h>
>  
>  #include "intel-pasid.h"
> @@ -332,16 +333,15 @@ int intel_svm_bind_mm(struct device *dev, int *pasid, int flags, struct svm_dev_
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
> @@ -351,7 +351,7 @@ int intel_svm_bind_mm(struct device *dev, int *pasid, int flags, struct svm_dev_
>  		if (mm) {
>  			ret = mmu_notifier_register(&svm->notifier, mm);
>  			if (ret) {
> -				intel_pasid_free_id(svm->pasid);
> +				ioasid_free(svm->pasid);
>  				kfree(svm);
>  				kfree(sdev);
>  				goto out;
> @@ -367,7 +367,7 @@ int intel_svm_bind_mm(struct device *dev, int *pasid, int flags, struct svm_dev_
>  		if (ret) {
>  			if (mm)
>  				mmu_notifier_unregister(&svm->notifier, mm);
> -			intel_pasid_free_id(svm->pasid);
> +			ioasid_free(svm->pasid);
>  			kfree(svm);
>  			kfree(sdev);
>  			goto out;
> @@ -400,7 +400,12 @@ int intel_svm_unbind_mm(struct device *dev, int pasid)
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
> @@ -422,7 +427,7 @@ int intel_svm_unbind_mm(struct device *dev, int pasid)
>  				kfree_rcu(sdev, rcu);
>  
>  				if (list_empty(&svm->devs)) {
> -					intel_pasid_free_id(svm->pasid);
> +					ioasid_free(svm->pasid);
>  					if (svm->mm)
>  						mmu_notifier_unregister(&svm->notifier, svm->mm);
>  
> @@ -457,10 +462,11 @@ int intel_svm_is_pasid_valid(struct device *dev, int pasid)
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
> @@ -567,13 +573,12 @@ static irqreturn_t prq_event_thread(int irq, void *d)
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


_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
