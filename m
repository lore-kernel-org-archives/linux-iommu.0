Return-Path: <SRS0=mWlM=CR=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FE16C433E2
	for <iommu@archiver.kernel.org>; Tue,  8 Sep 2020 09:52:41 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EDE082078E
	for <iommu@archiver.kernel.org>; Tue,  8 Sep 2020 09:52:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aohaeWiJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDE082078E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 7B8CE23355;
	Tue,  8 Sep 2020 09:52:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UvLtjh6EquLB; Tue,  8 Sep 2020 09:52:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id B809F20352;
	Tue,  8 Sep 2020 09:52:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8C351C0859;
	Tue,  8 Sep 2020 09:52:35 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8638FC0051
 for <iommu@lists.linux-foundation.org>; Tue,  8 Sep 2020 09:52:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 6D8A687267
 for <iommu@lists.linux-foundation.org>; Tue,  8 Sep 2020 09:52:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3m464cPNr2J2 for <iommu@lists.linux-foundation.org>;
 Tue,  8 Sep 2020 09:52:33 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [207.211.31.120])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 41E6B87233
 for <iommu@lists.linux-foundation.org>; Tue,  8 Sep 2020 09:52:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599558752;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lwg7JZDinfxU2pCtZZPMa9Zp0712Jq1IKLXYKSn2cqc=;
 b=aohaeWiJO50Gy9lnSmo7BlZNr/Y2DBrDBd27occWA4r0O9CIwfMdK/1VYAUlOyLkzDe2ja
 Qng+OfHrlrvX+zBV9h7whltNEVdjnJ9ITJrAqU+2i99exi4w3Ij4J5ZjghMOwCKH9/FqVo
 HkXoT7GlDhBu4hHj4xnOjdu+yfsLAzU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-217-O5wdYovPPNCyw0Glgl4CIg-1; Tue, 08 Sep 2020 05:52:29 -0400
X-MC-Unique: O5wdYovPPNCyw0Glgl4CIg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 705CA87309E;
 Tue,  8 Sep 2020 09:52:27 +0000 (UTC)
Received: from [10.36.114.107] (ovpn-114-107.ams2.redhat.com [10.36.114.107])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D6E317E30C;
 Tue,  8 Sep 2020 09:52:20 +0000 (UTC)
Subject: Re: [PATCH RESEND v9 02/13] iommu/ioasid: Add ioasid references
To: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org,
 linux-mm@kvack.org
References: <20200817171558.325917-1-jean-philippe@linaro.org>
 <20200817171558.325917-3-jean-philippe@linaro.org>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <2c4bf41e-aefa-de43-6100-d2b01494ba5b@redhat.com>
Date: Tue, 8 Sep 2020 11:52:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200817171558.325917-3-jean-philippe@linaro.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eric.auger@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: fenghua.yu@intel.com, will@kernel.org, zhengxiang9@huawei.com,
 catalin.marinas@arm.com, zhangfei.gao@linaro.org, robin.murphy@arm.com
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

Hi Jean,

On 8/17/20 7:15 PM, Jean-Philippe Brucker wrote:
> Let IOASID users take references to existing ioasids with ioasid_get().
> ioasid_put() drops a reference and only frees the ioasid when its
> reference number is zero. It returns true if the ioasid was freed.
> For drivers that don't call ioasid_get(), ioasid_put() is the same as
> ioasid_free().
> 
> Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Thanks

Eric

> ---
>  include/linux/ioasid.h      | 10 ++++++++--
>  drivers/iommu/intel/iommu.c |  4 ++--
>  drivers/iommu/intel/svm.c   |  6 +++---
>  drivers/iommu/ioasid.c      | 38 +++++++++++++++++++++++++++++++++----
>  4 files changed, 47 insertions(+), 11 deletions(-)
> 
> diff --git a/include/linux/ioasid.h b/include/linux/ioasid.h
> index 6f000d7a0ddc..e9dacd4b9f6b 100644
> --- a/include/linux/ioasid.h
> +++ b/include/linux/ioasid.h
> @@ -34,7 +34,8 @@ struct ioasid_allocator_ops {
>  #if IS_ENABLED(CONFIG_IOASID)
>  ioasid_t ioasid_alloc(struct ioasid_set *set, ioasid_t min, ioasid_t max,
>  		      void *private);
> -void ioasid_free(ioasid_t ioasid);
> +void ioasid_get(ioasid_t ioasid);
> +bool ioasid_put(ioasid_t ioasid);
>  void *ioasid_find(struct ioasid_set *set, ioasid_t ioasid,
>  		  bool (*getter)(void *));
>  int ioasid_register_allocator(struct ioasid_allocator_ops *allocator);
> @@ -48,10 +49,15 @@ static inline ioasid_t ioasid_alloc(struct ioasid_set *set, ioasid_t min,
>  	return INVALID_IOASID;
>  }
>  
> -static inline void ioasid_free(ioasid_t ioasid)
> +static inline void ioasid_get(ioasid_t ioasid)
>  {
>  }
>  
> +static inline bool ioasid_put(ioasid_t ioasid)
> +{
> +	return false;
> +}
> +
>  static inline void *ioasid_find(struct ioasid_set *set, ioasid_t ioasid,
>  				bool (*getter)(void *))
>  {
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index e9864e52b0e9..152fc2dc17e0 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -5149,7 +5149,7 @@ static void auxiliary_unlink_device(struct dmar_domain *domain,
>  	domain->auxd_refcnt--;
>  
>  	if (!domain->auxd_refcnt && domain->default_pasid > 0)
> -		ioasid_free(domain->default_pasid);
> +		ioasid_put(domain->default_pasid);
>  }
>  
>  static int aux_domain_add_dev(struct dmar_domain *domain,
> @@ -5210,7 +5210,7 @@ static int aux_domain_add_dev(struct dmar_domain *domain,
>  	spin_unlock(&iommu->lock);
>  	spin_unlock_irqrestore(&device_domain_lock, flags);
>  	if (!domain->auxd_refcnt && domain->default_pasid > 0)
> -		ioasid_free(domain->default_pasid);
> +		ioasid_put(domain->default_pasid);
>  
>  	return ret;
>  }
> diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
> index 95c3164a2302..50897a2bd1da 100644
> --- a/drivers/iommu/intel/svm.c
> +++ b/drivers/iommu/intel/svm.c
> @@ -565,7 +565,7 @@ intel_svm_bind_mm(struct device *dev, int flags, struct svm_dev_ops *ops,
>  		if (mm) {
>  			ret = mmu_notifier_register(&svm->notifier, mm);
>  			if (ret) {
> -				ioasid_free(svm->pasid);
> +				ioasid_put(svm->pasid);
>  				kfree(svm);
>  				kfree(sdev);
>  				goto out;
> @@ -583,7 +583,7 @@ intel_svm_bind_mm(struct device *dev, int flags, struct svm_dev_ops *ops,
>  		if (ret) {
>  			if (mm)
>  				mmu_notifier_unregister(&svm->notifier, mm);
> -			ioasid_free(svm->pasid);
> +			ioasid_put(svm->pasid);
>  			kfree(svm);
>  			kfree(sdev);
>  			goto out;
> @@ -652,7 +652,7 @@ static int intel_svm_unbind_mm(struct device *dev, int pasid)
>  			kfree_rcu(sdev, rcu);
>  
>  			if (list_empty(&svm->devs)) {
> -				ioasid_free(svm->pasid);
> +				ioasid_put(svm->pasid);
>  				if (svm->mm)
>  					mmu_notifier_unregister(&svm->notifier, svm->mm);
>  				list_del(&svm->list);
> diff --git a/drivers/iommu/ioasid.c b/drivers/iommu/ioasid.c
> index 0f8dd377aada..50ee27bbd04e 100644
> --- a/drivers/iommu/ioasid.c
> +++ b/drivers/iommu/ioasid.c
> @@ -2,7 +2,7 @@
>  /*
>   * I/O Address Space ID allocator. There is one global IOASID space, split into
>   * subsets. Users create a subset with DECLARE_IOASID_SET, then allocate and
> - * free IOASIDs with ioasid_alloc and ioasid_free.
> + * free IOASIDs with ioasid_alloc and ioasid_put.
>   */
>  #include <linux/ioasid.h>
>  #include <linux/module.h>
> @@ -15,6 +15,7 @@ struct ioasid_data {
>  	struct ioasid_set *set;
>  	void *private;
>  	struct rcu_head rcu;
> +	refcount_t refs;
>  };
>  
>  /*
> @@ -314,6 +315,7 @@ ioasid_t ioasid_alloc(struct ioasid_set *set, ioasid_t min, ioasid_t max,
>  
>  	data->set = set;
>  	data->private = private;
> +	refcount_set(&data->refs, 1);
>  
>  	/*
>  	 * Custom allocator needs allocator data to perform platform specific
> @@ -346,11 +348,34 @@ ioasid_t ioasid_alloc(struct ioasid_set *set, ioasid_t min, ioasid_t max,
>  EXPORT_SYMBOL_GPL(ioasid_alloc);
>  
>  /**
> - * ioasid_free - Free an IOASID
> + * ioasid_get - obtain a reference to the IOASID
> + */
> +void ioasid_get(ioasid_t ioasid)
> +{
> +	struct ioasid_data *ioasid_data;
> +
> +	spin_lock(&ioasid_allocator_lock);
> +	ioasid_data = xa_load(&active_allocator->xa, ioasid);
> +	if (ioasid_data)
> +		refcount_inc(&ioasid_data->refs);
> +	else
> +		WARN_ON(1);
> +	spin_unlock(&ioasid_allocator_lock);
> +}
> +EXPORT_SYMBOL_GPL(ioasid_get);
> +
> +/**
> + * ioasid_put - Release a reference to an ioasid
>   * @ioasid: the ID to remove
> + *
> + * Put a reference to the IOASID, free it when the number of references drops to
> + * zero.
> + *
> + * Return: %true if the IOASID was freed, %false otherwise.
>   */
> -void ioasid_free(ioasid_t ioasid)
> +bool ioasid_put(ioasid_t ioasid)
>  {
> +	bool free = false;
>  	struct ioasid_data *ioasid_data;
>  
>  	spin_lock(&ioasid_allocator_lock);
> @@ -360,6 +385,10 @@ void ioasid_free(ioasid_t ioasid)
>  		goto exit_unlock;
>  	}
>  
> +	free = refcount_dec_and_test(&ioasid_data->refs);
> +	if (!free)
> +		goto exit_unlock;
> +
>  	active_allocator->ops->free(ioasid, active_allocator->ops->pdata);
>  	/* Custom allocator needs additional steps to free the xa element */
>  	if (active_allocator->flags & IOASID_ALLOCATOR_CUSTOM) {
> @@ -369,8 +398,9 @@ void ioasid_free(ioasid_t ioasid)
>  
>  exit_unlock:
>  	spin_unlock(&ioasid_allocator_lock);
> +	return free;
>  }
> -EXPORT_SYMBOL_GPL(ioasid_free);
> +EXPORT_SYMBOL_GPL(ioasid_put);
>  
>  /**
>   * ioasid_find - Find IOASID data
> 

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
