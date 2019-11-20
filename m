Return-Path: <SRS0=wR7u=ZM=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6918DC432C0
	for <iommu@archiver.kernel.org>; Wed, 20 Nov 2019 21:06:44 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A15D2088F
	for <iommu@archiver.kernel.org>; Wed, 20 Nov 2019 21:06:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FTmc1NlR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A15D2088F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id D14F31FF59;
	Wed, 20 Nov 2019 21:06:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wFdfiHI3LNW7; Wed, 20 Nov 2019 21:06:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 971BC1FEAB;
	Wed, 20 Nov 2019 21:06:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7CA9EC1DC9;
	Wed, 20 Nov 2019 21:06:42 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DF0B3C18DA
 for <iommu@lists.linux-foundation.org>; Wed, 20 Nov 2019 21:06:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id CC4161FF59
 for <iommu@lists.linux-foundation.org>; Wed, 20 Nov 2019 21:06:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id og7Vr6nMGOWx for <iommu@lists.linux-foundation.org>;
 Wed, 20 Nov 2019 21:06:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-2.mimecast.com
 [207.211.31.81])
 by silver.osuosl.org (Postfix) with ESMTPS id AA57C1FEAB
 for <iommu@lists.linux-foundation.org>; Wed, 20 Nov 2019 21:06:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574283996;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=t22FsjCBe/pgglckOhOYEXus63aVy7knMeEl8aZlZwM=;
 b=FTmc1NlRqAxv9MbFlmoVdMyDYwu1m9v3jYrBsoIb/gmKlPV9P79NuOM+MO3dGtmlkNkBGz
 Eq2RtxwYo1NRf1onFparUbus9xRvAJGRGbbqFuQu1ea3Ry5tMkY0FLJO64W3INu01BaVgK
 jM3rTz4csa+cneE6Kd4GSsv/9iuBK0Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-181-Y-aXBW0EM-CnElzS9mDa3g-1; Wed, 20 Nov 2019 16:06:32 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A069EDC29;
 Wed, 20 Nov 2019 21:06:30 +0000 (UTC)
Received: from [10.36.116.37] (ovpn-116-37.ams2.redhat.com [10.36.116.37])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 868F350A93;
 Wed, 20 Nov 2019 21:06:27 +0000 (UTC)
Subject: Re: [PATCH v3 6/8] iommu/vt-d: Replace Intel specific PASID allocator
 with IOASID
To: Jacob Pan <jacob.jun.pan@linux.intel.com>,
 iommu@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>,
 Joerg Roedel <joro@8bytes.org>, Lu Baolu <baolu.lu@linux.intel.com>,
 David Woodhouse <dwmw2@infradead.org>
References: <1574186193-30457-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1574186193-30457-7-git-send-email-jacob.jun.pan@linux.intel.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <5ead3e84-d6b6-8f97-c83b-236bbe53be86@redhat.com>
Date: Wed, 20 Nov 2019 22:06:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1574186193-30457-7-git-send-email-jacob.jun.pan@linux.intel.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: Y-aXBW0EM-CnElzS9mDa3g-1
X-Mimecast-Spam-Score: 0
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Raj Ashok <ashok.raj@intel.com>
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

Hi Jacob,

On 11/19/19 6:56 PM, Jacob Pan wrote:
> Make use of generic IOASID code to manage PASID allocation,
> free, and lookup. Replace Intel specific code.
> IOASID allocator is inclusive for both start and end of the allocation
> range. The current code is based on IDR, which is exclusive for
> the end of the allocation range. This patch fixes the off-by-one
> error in intel_svm_bind_mm, where pasid_max - 1 is used for the end of
> allocation range.
no more as this is handled in 5/8
> 
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
> Acked-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/Kconfig       |  1 +
>  drivers/iommu/intel-iommu.c | 13 +++++++------
>  drivers/iommu/intel-pasid.c | 36 ------------------------------------
>  drivers/iommu/intel-svm.c   | 39 +++++++++++++++++++++++++--------------
>  4 files changed, 33 insertions(+), 56 deletions(-)
> 
> diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> index fd50ddffffbf..43ce450a40d3 100644
> --- a/drivers/iommu/Kconfig
> +++ b/drivers/iommu/Kconfig
> @@ -212,6 +212,7 @@ config INTEL_IOMMU_SVM
>  	depends on INTEL_IOMMU && X86
>  	select PCI_PASID
>  	select MMU_NOTIFIER
> +	select IOASID
>  	help
>  	  Shared Virtual Memory (SVM) provides a facility for devices
>  	  to access DMA resources through process address space by
> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> index d598168e410d..a84f0caa33a0 100644
> --- a/drivers/iommu/intel-iommu.c
> +++ b/drivers/iommu/intel-iommu.c
> @@ -5238,7 +5238,7 @@ static void auxiliary_unlink_device(struct dmar_domain *domain,
>  	domain->auxd_refcnt--;
>  
>  	if (!domain->auxd_refcnt && domain->default_pasid > 0)
> -		intel_pasid_free_id(domain->default_pasid);
> +		ioasid_free(domain->default_pasid);
>  }
>  
>  static int aux_domain_add_dev(struct dmar_domain *domain,
> @@ -5256,10 +5256,11 @@ static int aux_domain_add_dev(struct dmar_domain *domain,
>  	if (domain->default_pasid <= 0) {
>  		int pasid;
>  
> -		pasid = intel_pasid_alloc_id(domain, PASID_MIN,
> -					     pci_max_pasids(to_pci_dev(dev)),
> -					     GFP_KERNEL);
> -		if (pasid <= 0) {
> +		/* No private data needed for the default pasid */
> +		pasid = ioasid_alloc(NULL, PASID_MIN,
> +				     pci_max_pasids(to_pci_dev(dev)) - 1,
> +				     NULL);
> +		if (pasid == INVALID_IOASID) {
>  			pr_err("Can't allocate default pasid\n");
>  			return -ENODEV;
>  		}
> @@ -5295,7 +5296,7 @@ static int aux_domain_add_dev(struct dmar_domain *domain,
>  	spin_unlock(&iommu->lock);
>  	spin_unlock_irqrestore(&device_domain_lock, flags);
>  	if (!domain->auxd_refcnt && domain->default_pasid > 0)
> -		intel_pasid_free_id(domain->default_pasid);
> +		ioasid_free(domain->default_pasid);
>  
>  	return ret;
>  }
> diff --git a/drivers/iommu/intel-pasid.c b/drivers/iommu/intel-pasid.c
> index 732bfee228df..3cb569e76642 100644
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
>  /*
>   * Per device pasid table management:
> diff --git a/drivers/iommu/intel-svm.c b/drivers/iommu/intel-svm.c
> index e90d0b914afe..71b85b892c56 100644
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
> @@ -335,16 +336,15 @@ int intel_svm_bind_mm(struct device *dev, int *pasid, int flags, struct svm_dev_
>  		if (pasid_max > intel_pasid_max_id)
>  			pasid_max = intel_pasid_max_id;
>  
> -		/* Do not use PASID 0 in caching mode (virtualised IOMMU) */
> -		ret = intel_pasid_alloc_id(svm,
> -					   !!cap_caching_mode(iommu->cap),
> -					   pasid_max, GFP_KERNEL);
> -		if (ret < 0) {
> +		/* Do not use PASID 0, reserved for RID to PASID */
> +		svm->pasid = ioasid_alloc(NULL, PASID_MIN,
> +					  pasid_max - 1, svm);
> +		if (svm->pasid == INVALID_IOASID) {
>  			kfree(svm);
>  			kfree(sdev);
> +			ret = -ENOSPC;
>  			goto out;
>  		}
> -		svm->pasid = ret;
>  		svm->notifier.ops = &intel_mmuops;
>  		svm->mm = mm;
>  		svm->flags = flags;
> @@ -354,7 +354,7 @@ int intel_svm_bind_mm(struct device *dev, int *pasid, int flags, struct svm_dev_
>  		if (mm) {
>  			ret = mmu_notifier_register(&svm->notifier, mm);
>  			if (ret) {
> -				intel_pasid_free_id(svm->pasid);
> +				ioasid_free(svm->pasid);
>  				kfree(svm);
>  				kfree(sdev);
>  				goto out;
> @@ -370,7 +370,7 @@ int intel_svm_bind_mm(struct device *dev, int *pasid, int flags, struct svm_dev_
>  		if (ret) {
>  			if (mm)
>  				mmu_notifier_unregister(&svm->notifier, mm);
> -			intel_pasid_free_id(svm->pasid);
> +			ioasid_free(svm->pasid);
>  			kfree(svm);
>  			kfree(sdev);
>  			goto out;
> @@ -418,7 +418,15 @@ int intel_svm_unbind_mm(struct device *dev, int pasid)
>  	if (!iommu)
>  		goto out;
>  
> -	svm = intel_pasid_lookup_id(pasid);
> +	svm = ioasid_find(NULL, pasid, NULL);
> +	if (!svm)
> +		goto out;
> +
> +	if (IS_ERR(svm)) {
> +		ret = PTR_ERR(svm);
> +		goto out;
> +	}
> +
>  	if (!svm)
>  		goto out;
>  
> @@ -440,7 +448,7 @@ int intel_svm_unbind_mm(struct device *dev, int pasid)
>  				kfree_rcu(sdev, rcu);
>  
>  				if (list_empty(&svm->devs)) {
> -					intel_pasid_free_id(svm->pasid);
> +					ioasid_free(svm->pasid);
>  					if (svm->mm)
>  						mmu_notifier_unregister(&svm->notifier, svm->mm);
>  
> @@ -475,10 +483,14 @@ int intel_svm_is_pasid_valid(struct device *dev, int pasid)
>  	if (!iommu)
>  		goto out;
>  
> -	svm = intel_pasid_lookup_id(pasid);
> +	svm = ioasid_find(NULL, pasid, NULL);
>  	if (!svm)
>  		goto out;
>  
> +	if (IS_ERR(svm)) {
> +		ret = PTR_ERR(svm);
> +		goto out;
> +	}
>  	/* init_mm is used in this case */
>  	if (!svm->mm)
>  		ret = 1;
> @@ -585,13 +597,12 @@ static irqreturn_t prq_event_thread(int irq, void *d)
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
> +			if (IS_ERR_OR_NULL(svm)) {
>  				pr_err("%s: Page request for invalid PASID %d: %08llx %08llx\n",
>  				       iommu->name, req->pasid, ((unsigned long long *)req)[0],
>  				       ((unsigned long long *)req)[1]);
> 
Besides
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Thanks

Eric

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
