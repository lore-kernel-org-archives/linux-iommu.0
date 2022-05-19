Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C7A9C433EF
	for <iommu@archiver.kernel.org>; Thu, 19 May 2022 16:40:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 273FA612FC;
	Thu, 19 May 2022 16:40:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bfQWr6k-16Do; Thu, 19 May 2022 16:40:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id C53F1612F8;
	Thu, 19 May 2022 16:40:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AD422C0039;
	Thu, 19 May 2022 16:40:50 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BAD34C002D
 for <iommu@lists.linux-foundation.org>; Thu, 19 May 2022 16:40:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9859B40438
 for <iommu@lists.linux-foundation.org>; Thu, 19 May 2022 16:40:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BPXbbvNdBlV6 for <iommu@lists.linux-foundation.org>;
 Thu, 19 May 2022 16:40:48 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 86F2D4012A
 for <iommu@lists.linux-foundation.org>; Thu, 19 May 2022 16:40:48 +0000 (UTC)
Received: by mail-wr1-x42b.google.com with SMTP id f2so8044285wrc.0
 for <iommu@lists.linux-foundation.org>; Thu, 19 May 2022 09:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=g9gYzxWe5NPTbaNAHgbnlMxkb6BQm0o5fPGCfOasomw=;
 b=odGYCXlYMgIzbmhlZajrwAIYrVzVwUGAygS7xDgeEP2rU4W9fYXMtAowdDXWjBuBmN
 N8vUt46PYTxRHIXJUvYhROlIHPsqU+g8ONQJuDAnApcUSeY7b/s6sHKiwpUirq7+VyBb
 T7moq/nxrXA/AYNVxABM+qr+9lTbgERS0jZv+fu7vIqCofJukIpMY8o8Oe8pKbdNmnKN
 PonSzsSzBbtH4erc+IOjytHkSynceUJCBS5xGilAl5fN01iDARm7T9xNJsLRhFmiEd/Y
 SzY4ujloji/i0hf3ldGrjkCz+MwG4nB7+jUg2kfQshpg+oVxpXyaY4KvU73lYn2yOa+7
 rCvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=g9gYzxWe5NPTbaNAHgbnlMxkb6BQm0o5fPGCfOasomw=;
 b=FRlsUZ0gNEno3VDMceFWYUdXM7n4t2HuqnAzpgod2SVsTZnvqg/e5E17Y+8mz3jjEz
 eSdfzeToIzoEUAb/VIQwT51+lFK5sRefYbmY9Io5hjvOfraCbgllInvd8Y0BJa66O8b9
 CQCsCQf3VTBD0m8u6aejmQcmppi/nv84mql7ES/J6DhNvFzHsDj8k/d3lqdE1EfBm4h/
 zODgGpskF8thgwHNcd1K1e8Z4i/PhLbw0q4brmMN1F96b/m/r9hGM0GBJSjOphk4VttK
 v2NImo1m0h+oT9MyFqyFGXmEVDIslXQ76JRQOY47NIpDGkq3hEZO/+Jn2IYDsZYOprG5
 EooQ==
X-Gm-Message-State: AOAM53025t45vBQ6l1YmLvl3ytrI84kNN4INz6NRv13A0f2VfapAZYeD
 6wrAwMDYSvYjud+xzrDgEGqIVQ==
X-Google-Smtp-Source: ABdhPJwmsiBN/XwBVe8E5Ys3+WsVkowKP+Je5QRAj4S9lPWo204wsjJqP+iG7dMMB7RDwhMffQZlkw==
X-Received: by 2002:a5d:4ad1:0:b0:20d:b23:fe1b with SMTP id
 y17-20020a5d4ad1000000b0020d0b23fe1bmr4752812wrs.579.1652978446569; 
 Thu, 19 May 2022 09:40:46 -0700 (PDT)
Received: from myrica (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net.
 [82.27.106.168]) by smtp.gmail.com with ESMTPSA id
 z6-20020a7bc146000000b003942a244ebesm77922wmi.3.2022.05.19.09.40.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 May 2022 09:40:46 -0700 (PDT)
Date: Thu, 19 May 2022 17:40:21 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v7 08/10] iommu: Prepare IOMMU domain for IOPF
Message-ID: <YoZy9fnJlN/RIVY4@myrica>
References: <20220519072047.2996983-1-baolu.lu@linux.intel.com>
 <20220519072047.2996983-9-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220519072047.2996983-9-baolu.lu@linux.intel.com>
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

On Thu, May 19, 2022 at 03:20:45PM +0800, Lu Baolu wrote:
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
> This also prepares the SVA implementation to be the first consumer of
> the per-domain page fault handling model.
> 
> Suggested-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  include/linux/iommu.h         |  3 ++
>  drivers/iommu/io-pgfault.c    |  7 ++++
>  drivers/iommu/iommu-sva-lib.c | 65 +++++++++++++++++++++++++++++++++++
>  3 files changed, 75 insertions(+)
> 
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index e4ce2fe0e144..45f274b2640d 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -100,6 +100,9 @@ struct iommu_domain {
>  	void *handler_token;
>  	struct iommu_domain_geometry geometry;
>  	struct iommu_dma_cookie *iova_cookie;
> +	enum iommu_page_response_code (*iopf_handler)(struct iommu_fault *fault,
> +						      void *data);
> +	void *fault_data;
>  };
>  
>  static inline bool iommu_is_dma_domain(struct iommu_domain *domain)
> diff --git a/drivers/iommu/io-pgfault.c b/drivers/iommu/io-pgfault.c
> index 1df8c1dcae77..aee9e033012f 100644
> --- a/drivers/iommu/io-pgfault.c
> +++ b/drivers/iommu/io-pgfault.c
> @@ -181,6 +181,13 @@ static void iopf_handle_group(struct work_struct *work)
>   * request completes, outstanding faults will have been dealt with by the time
>   * the PASID is freed.
>   *
> + * Any valid page fault will be eventually routed to an iommu domain and the
> + * page fault handler installed there will get called. The users of this
> + * handling framework should guarantee that the iommu domain could only be
> + * freed after the device has stopped generating page faults (or the iommu
> + * hardware has been set to block the page faults) and the pending page faults
> + * have been flushed.
> + *
>   * Return: 0 on success and <0 on error.
>   */
>  int iommu_queue_iopf(struct iommu_fault *fault, void *cookie)
> diff --git a/drivers/iommu/iommu-sva-lib.c b/drivers/iommu/iommu-sva-lib.c
> index 568e0f64edac..317ab8e8c149 100644
> --- a/drivers/iommu/iommu-sva-lib.c
> +++ b/drivers/iommu/iommu-sva-lib.c
> @@ -72,6 +72,69 @@ struct mm_struct *iommu_sva_find(ioasid_t pasid)
>  }
>  EXPORT_SYMBOL_GPL(iommu_sva_find);
>  
> +/*
> + * I/O page fault handler for SVA
> + *
> + * Copied from io-pgfault.c with mmget_not_zero() added before
> + * mmap_read_lock().

Comment doesn't really belong here, maybe better in the commit message.
Apart from that

Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>

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
> +	mm = domain_to_mm(domain);
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
> @@ -94,6 +157,8 @@ iommu_sva_alloc_domain(struct bus_type *bus, struct mm_struct *mm)
>  	domain = &sva_domain->domain;
>  	domain->type = IOMMU_DOMAIN_SVA;
>  	domain->ops = bus->iommu_ops->sva_domain_ops;
> +	domain->iopf_handler = iommu_sva_handle_iopf;
> +	domain->fault_data = domain;
>  
>  	return domain;
>  }
> -- 
> 2.25.1
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
