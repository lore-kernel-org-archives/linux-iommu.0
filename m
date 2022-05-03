Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8C20C433EF
	for <iommu@archiver.kernel.org>; Tue,  3 May 2022 18:22:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 6903D40B37;
	Tue,  3 May 2022 18:22:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id H61XHA3kSraq; Tue,  3 May 2022 18:22:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 15A6A40B02;
	Tue,  3 May 2022 18:22:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E6087C0032;
	Tue,  3 May 2022 18:22:28 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BE0B9C002D
 for <iommu@lists.linux-foundation.org>; Tue,  3 May 2022 18:22:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9D7E961038
 for <iommu@lists.linux-foundation.org>; Tue,  3 May 2022 18:22:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OCV5WxEBYvrC for <iommu@lists.linux-foundation.org>;
 Tue,  3 May 2022 18:22:26 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3310A60B9D
 for <iommu@lists.linux-foundation.org>; Tue,  3 May 2022 18:22:26 +0000 (UTC)
Received: by mail-wm1-x332.google.com with SMTP id
 m2-20020a1ca302000000b003943bc63f98so1730641wme.4
 for <iommu@lists.linux-foundation.org>; Tue, 03 May 2022 11:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=i0V2Vyl4bDKVL0HjXFNOtxsvt4FGworOE/C722VAmi8=;
 b=M7CMGC+LWjgzKt8+YtTXmZLOGYj6UefbuPujXupr9SKG3rroSirbV54A+oGvsuShYn
 lp/HMS+oaVuiTLXRgxmu+MaIjyWFnwQTBi+Ab7T65vnYQN36ltVuez2rUzDxRyXc4kmZ
 3ChAusx59CX1+rROBTkZEdQ8YYe2KC7ffE1tqxoFhGyXKkPugRcNGPjo2ma3AmCgFdCn
 wsiB8vOTK+Gt+KT4Hq7SLJSipEMd+l+cHaHr7gZfV06HbvWa4t0c/upRC3JQGWO+uuMz
 jgZON1tvaw6nBcyxXu+uGaYeVtR71/TFkLZiuiUtIzcu6nMMggX0G7vFFrjXPyjcRL7L
 vSIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=i0V2Vyl4bDKVL0HjXFNOtxsvt4FGworOE/C722VAmi8=;
 b=NCebi0LnfC2axqy6Nz0j2L1po7KLDoinSmJvQszRr9revXASuncEoPnBsW0wLFGQsW
 riNVHNk2nUkA2afkXlA3mEQtd03UpfLklucPs72cGuuUJoRoaM1ZyQVde6R2iwReCqEr
 67jm34VAszzs+3fjHf+paySO1d2bAX7aQP09nIwAg23GYOV/Goq3oxKrMmZ+lL0d1rLl
 mOR0L0l9hyIx6uvYHNTP5JsQ2YAu1Iosqr/6zyy/H5m4cs8XJpXWHvhjiNmqOCmC1Hgh
 pJ+ZH4r0s6qFHvt02/5Om4rmSkm1tH10XI5PAKZ4rJayY0eFL0SitxyKCpoFjydDR21N
 SvXg==
X-Gm-Message-State: AOAM532BZHigpKcwXG+DVb3AI7+vrACiN6zdLEc055QQ2/Clq5mtKeMI
 3xG3glS54MAnRvm01e8CzX8W6w==
X-Google-Smtp-Source: ABdhPJzGqjK6O9NC2TRoxIq/n+y46goRU1n2lantDNUaD7rwgviPOYeLTVYP24eimpvDPofFR9iz1g==
X-Received: by 2002:a1c:770b:0:b0:394:3fae:ab79 with SMTP id
 t11-20020a1c770b000000b003943faeab79mr4424991wmi.200.1651602144310; 
 Tue, 03 May 2022 11:22:24 -0700 (PDT)
Received: from myrica (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net.
 [82.27.106.168]) by smtp.gmail.com with ESMTPSA id
 v13-20020adfa1cd000000b0020c5253d8b9sm9622540wrv.5.2022.05.03.11.21.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 May 2022 11:21:45 -0700 (PDT)
Date: Tue, 3 May 2022 19:20:36 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v5 10/12] iommu: Prepare IOMMU domain for IOPF
Message-ID: <YnFydE8j8l7Q4m+b@myrica>
References: <20220502014842.991097-1-baolu.lu@linux.intel.com>
 <20220502014842.991097-11-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220502014842.991097-11-baolu.lu@linux.intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 Ashok Raj <ashok.raj@intel.com>, Robin Murphy <robin.murphy@arm.com>,
 iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 Christoph Hellwig <hch@infradead.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 Vinod Koul <vkoul@kernel.org>, Jacob jun Pan <jacob.jun.pan@intel.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Will Deacon <will@kernel.org>
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

On Mon, May 02, 2022 at 09:48:40AM +0800, Lu Baolu wrote:
> This adds some mechanisms around the iommu_domain so that the I/O page
> fault handling framework could route a page fault to the domain and
> call the fault handler from it.
> 
> Add pointers to the page fault handler and its private data in struct
> iommu_domain. The fault handler will be called with the private data
> as a parameter once a page fault is routed to the domain. Any kernel
> component which owns an iommu domain could install handler and its
> private parameter so that the page fault could be further routed and
> handled.
> 
> A new helper iommu_get_domain_for_dev_pasid() which retrieves attached
> domain for a {device, PASID} is added. It will be used by the page fault
> handling framework which knows {device, PASID} reported from the iommu
> driver. We have a guarantee that the SVA domain doesn't go away during
> IOPF handling, because unbind() waits for pending faults with
> iopf_queue_flush_dev() before freeing the domain. Hence, there's no need
> to synchronize life cycle of the iommu domains between the unbind() and
> the interrupt threads.
> 
> This also prepares the SVA implementation to be the first consumer of
> the per-domain page fault handling model.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  include/linux/iommu.h         | 12 +++++++
>  drivers/iommu/iommu-sva-lib.c | 65 +++++++++++++++++++++++++++++++++++
>  drivers/iommu/iommu.c         | 21 +++++++++++
>  3 files changed, 98 insertions(+)
> 
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 19718939d9df..1164524814cb 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -102,6 +102,9 @@ struct iommu_domain {
>  	struct iommu_domain_geometry geometry;
>  	struct iommu_dma_cookie *iova_cookie;
>  	struct iommu_sva_ioas *sva_ioas;
> +	enum iommu_page_response_code (*iopf_handler)(struct iommu_fault *fault,
> +						      void *data);
> +	void *fault_data;
>  };
>  
>  static inline bool iommu_is_dma_domain(struct iommu_domain *domain)
> @@ -686,6 +689,9 @@ int iommu_attach_device_pasid(struct iommu_domain *domain,
>  			      struct device *dev, ioasid_t pasid);
>  void iommu_detach_device_pasid(struct iommu_domain *domain,
>  			       struct device *dev, ioasid_t pasid);
> +struct iommu_domain *
> +iommu_get_domain_for_dev_pasid(struct device *dev, ioasid_t pasid);
> +
>  #else /* CONFIG_IOMMU_API */
>  
>  struct iommu_ops {};
> @@ -1055,6 +1061,12 @@ static inline void iommu_detach_device_pasid(struct iommu_domain *domain,
>  					     struct device *dev, ioasid_t pasid)
>  {
>  }
> +
> +static inline struct iommu_domain *
> +iommu_get_domain_for_dev_pasid(struct device *dev, ioasid_t pasid)
> +{
> +	return NULL;
> +}
>  #endif /* CONFIG_IOMMU_API */
>  
>  #ifdef CONFIG_IOMMU_SVA
> diff --git a/drivers/iommu/iommu-sva-lib.c b/drivers/iommu/iommu-sva-lib.c
> index 992388106da0..05a7d2f0e46f 100644
> --- a/drivers/iommu/iommu-sva-lib.c
> +++ b/drivers/iommu/iommu-sva-lib.c
> @@ -135,6 +135,69 @@ static void iommu_sva_ioas_put(struct iommu_sva_ioas *ioas)
>  	}
>  }
>  
> +/*
> + * I/O page fault handler for SVA
> + *
> + * Copied from io-pgfault.c with mmget_not_zero() added before
> + * mmap_read_lock().
> + */
> +static enum iommu_page_response_code
> +iommu_sva_handle_iopf(struct iommu_fault *fault, void *data)
> +{
> +	vm_fault_t ret;
> +	struct mm_struct *mm;
> +	struct vm_area_struct *vma;
> +	unsigned int access_flags = 0;
> +	struct iommu_domain *domain = data;
> +	unsigned int fault_flags = FAULT_FLAG_REMOTE;
> +	struct iommu_fault_page_request *prm = &fault->prm;
> +	enum iommu_page_response_code status = IOMMU_PAGE_RESP_INVALID;
> +
> +	if (!(prm->flags & IOMMU_FAULT_PAGE_REQUEST_PASID_VALID))
> +		return status;
> +
> +	mm = iommu_sva_domain_mm(domain);
> +	if (IS_ERR_OR_NULL(mm) || !mmget_not_zero(mm))
> +		return status;
> +
> +	mmap_read_lock(mm);
> +
> +	vma = find_extend_vma(mm, prm->addr);
> +	if (!vma)
> +		/* Unmapped area */
> +		goto out_put_mm;
> +
> +	if (prm->perm & IOMMU_FAULT_PERM_READ)
> +		access_flags |= VM_READ;
> +
> +	if (prm->perm & IOMMU_FAULT_PERM_WRITE) {
> +		access_flags |= VM_WRITE;
> +		fault_flags |= FAULT_FLAG_WRITE;
> +	}
> +
> +	if (prm->perm & IOMMU_FAULT_PERM_EXEC) {
> +		access_flags |= VM_EXEC;
> +		fault_flags |= FAULT_FLAG_INSTRUCTION;
> +	}
> +
> +	if (!(prm->perm & IOMMU_FAULT_PERM_PRIV))
> +		fault_flags |= FAULT_FLAG_USER;
> +
> +	if (access_flags & ~vma->vm_flags)
> +		/* Access fault */
> +		goto out_put_mm;
> +
> +	ret = handle_mm_fault(vma, prm->addr, fault_flags, NULL);
> +	status = ret & VM_FAULT_ERROR ? IOMMU_PAGE_RESP_INVALID :
> +		IOMMU_PAGE_RESP_SUCCESS;
> +
> +out_put_mm:
> +	mmap_read_unlock(mm);
> +	mmput(mm);
> +
> +	return status;
> +}
> +
>  /*
>   * IOMMU SVA driver-oriented interfaces
>   */
> @@ -154,6 +217,8 @@ iommu_sva_alloc_domain(struct device *dev, struct iommu_sva_ioas *ioas)
>  	/* The caller must hold a reference to ioas. */
>  	domain->sva_ioas = ioas;
>  	domain->type = IOMMU_DOMAIN_SVA;
> +	domain->iopf_handler = iommu_sva_handle_iopf;
> +	domain->fault_data = domain;
>  
>  	return domain;
>  }
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 7cae631c1baa..33449523afbe 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -3174,3 +3174,24 @@ void iommu_detach_device_pasid(struct iommu_domain *domain,
>  
>  	iommu_group_put(group);
>  }
> +
> +struct iommu_domain *iommu_get_domain_for_dev_pasid(struct device *dev,
> +						    ioasid_t pasid)
> +{
> +	struct iommu_domain *domain;
> +	struct iommu_group *group;
> +
> +	if (!pasid_valid(pasid))
> +		return NULL;
> +
> +	group = iommu_group_get(dev);
> +	if (!group)
> +		return NULL;
> +
> +	mutex_lock(&group->mutex);

Unfortunately this still causes the deadlock when unbind() flushes the
IOPF queue while holding the group mutex.

If we make this function private to IOPF, then we can get rid of this
mutex_lock(). It's OK because:

* xarray protects its internal state with RCU, so we can call
  xa_load() outside the lock.

* The domain obtained from xa_load is finalized. Its content is valid
  because xarray stores the domain using rcu_assign_pointer(), which has a
  release memory barrier, which pairs with data dependencies in IOPF
  (domain->sva_ioas etc).

  We'll need to be careful about this when allowing other users to install
  a fault handler. Should be fine as long as the handler and data are
  installed before the domain is added to pasid_array.

* We know the domain is valid the whole time IOPF is using it, because
  unbind() waits for pending faults.

We just need a comment explaining the last point, something like:

       /*
	* Safe to fetch outside the group mutex because:
        * - xarray protects its internal state with RCU
        * - the domain obtained is either NULL or fully formed
	* - the IOPF work is the only caller and is flushed before the
	*   domain is freed.
        */

Thanks,
Jean

> +	domain = xa_load(&group->pasid_array, pasid);
> +	mutex_unlock(&group->mutex);
> +	iommu_group_put(group);
> +
> +	return domain;
> +}
> -- 
> 2.25.1
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
