Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CDF4C433EF
	for <iommu@archiver.kernel.org>; Tue,  3 May 2022 18:28:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 1081640B19;
	Tue,  3 May 2022 18:28:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5Rz6LQkGNMMJ; Tue,  3 May 2022 18:28:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id D0C8C400F8;
	Tue,  3 May 2022 18:28:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B7354C0032;
	Tue,  3 May 2022 18:28:10 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E061BC002D
 for <iommu@lists.linux-foundation.org>; Tue,  3 May 2022 18:28:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id CE90460625
 for <iommu@lists.linux-foundation.org>; Tue,  3 May 2022 18:28:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dZNCsK6WBf5z for <iommu@lists.linux-foundation.org>;
 Tue,  3 May 2022 18:28:09 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com
 [IPv6:2607:f8b0:4864:20::f30])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E29AE605EA
 for <iommu@lists.linux-foundation.org>; Tue,  3 May 2022 18:28:08 +0000 (UTC)
Received: by mail-qv1-xf30.google.com with SMTP id ke5so12802137qvb.5
 for <iommu@lists.linux-foundation.org>; Tue, 03 May 2022 11:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=omdkLVWDymQZwApjqvxbw+i1IH3FdHIBVFJO4bGVqyI=;
 b=DZjpOmlvJkEmvY6d/bKYqPzIi24+OeGX9jjIL1fRQBlGnQyRcaJSY6GECW1aUJfma0
 16mBAopmEHhJukXrELjrHDtNYd+J183Y7CFrMNr4bL00tnXO3bjJD+lEHdtmA1b4f5ca
 t9Tik0wWV6w1j5ntsyzyPB/J/Zm55em5wVK6eQSEkm6WOsdY8UIox9Z7hOkxOl7HT9j2
 CrImIvQb3hRMRn5TT/zqURzPa6UxhqmiJd7LWonHoc8inpsGFMY0bzYzdNXwJ4WYSzme
 8trdRJTIGtP7/CLa+DQkDFsCvYMtrRyh346O2SEIkZRFtpekhfZT5iB0gnFabNEnb/4S
 Fw/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=omdkLVWDymQZwApjqvxbw+i1IH3FdHIBVFJO4bGVqyI=;
 b=mc0gvWIHFka//0rm88bHktw57i/RJtdV/jjplnwtdP3PDqXzpQYxF/zGfhVMgt4a1F
 O1e2yOWfm/Qkx+FMfzhuYlkGhyIZ8Ryhh5hYIvzGYvdFeUFGPmBUw1xlGE6qIbac+3qz
 wT9lk6NwUE/yiS58SbYYvev9c9v3GFynpzF7MPUF64gGOfNaPgOnoX0hoqhRpww/IgEi
 oSnbi8d6gp6txXrNQ7EKAQ3+bS0NNer/KnH/IzjvmusoKnLhad4cxTQOai9p3eww9ufw
 lPx4ABrYv8U8wYTjuPfarWKvJeOVUzqfDzaDvKWEYL8HSFMBuL1CQwfqW4MVKU3pkK4S
 dg4w==
X-Gm-Message-State: AOAM533RJvZlkOEUDoyL/xq9UXJiBehC/NiZ1kuxSdWVDDlCRrm2SLhi
 RY8mysfT5xE+CF7UwJg2INntZA==
X-Google-Smtp-Source: ABdhPJwOlpxWUgmZpdOzEfMjW+Eiq6I++GhxgdqnzUuXMGEE76f61tep+acbkbO28XntM7RF2CDvlg==
X-Received: by 2002:a05:6214:519a:b0:456:3d2b:92e with SMTP id
 kl26-20020a056214519a00b004563d2b092emr14768392qvb.100.1651602487803; 
 Tue, 03 May 2022 11:28:07 -0700 (PDT)
Received: from myrica (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net.
 [82.27.106.168]) by smtp.gmail.com with ESMTPSA id
 g77-20020a379d50000000b0069fc13ce21bsm6362583qke.76.2022.05.03.11.28.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 May 2022 11:28:07 -0700 (PDT)
Date: Tue, 3 May 2022 19:27:40 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v5 11/12] iommu: Per-domain I/O page fault handling
Message-ID: <YnF0HIreC1hV4sss@myrica>
References: <20220502014842.991097-1-baolu.lu@linux.intel.com>
 <20220502014842.991097-12-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220502014842.991097-12-baolu.lu@linux.intel.com>
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

On Mon, May 02, 2022 at 09:48:41AM +0800, Lu Baolu wrote:
> Tweak the I/O page fault handling framework to route the page faults to
> the domain and call the page fault handler retrieved from the domain.
> This makes the I/O page fault handling framework possible to serve more
> usage scenarios as long as they have an IOMMU domain and install a page
> fault handler in it. Some unused functions are also removed to avoid
> dead code.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>

Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>

> ---
>  drivers/iommu/iommu-sva-lib.h |  1 -
>  drivers/iommu/io-pgfault.c    | 64 ++++-------------------------------
>  drivers/iommu/iommu-sva-lib.c | 20 -----------
>  3 files changed, 7 insertions(+), 78 deletions(-)
> 
> diff --git a/drivers/iommu/iommu-sva-lib.h b/drivers/iommu/iommu-sva-lib.h
> index 5776b4c80cc1..e7813c6706fb 100644
> --- a/drivers/iommu/iommu-sva-lib.h
> +++ b/drivers/iommu/iommu-sva-lib.h
> @@ -8,7 +8,6 @@
>  #include <linux/ioasid.h>
>  #include <linux/mm_types.h>
>  
> -struct mm_struct *iommu_sva_find(ioasid_t pasid);
>  struct mm_struct *iommu_sva_domain_mm(struct iommu_domain *domain);
>  
>  /* I/O Page fault */
> diff --git a/drivers/iommu/io-pgfault.c b/drivers/iommu/io-pgfault.c
> index 1df8c1dcae77..8a2bb56e1474 100644
> --- a/drivers/iommu/io-pgfault.c
> +++ b/drivers/iommu/io-pgfault.c
> @@ -69,69 +69,18 @@ static int iopf_complete_group(struct device *dev, struct iopf_fault *iopf,
>  	return iommu_page_response(dev, &resp);
>  }
>  
> -static enum iommu_page_response_code
> -iopf_handle_single(struct iopf_fault *iopf)
> -{
> -	vm_fault_t ret;
> -	struct mm_struct *mm;
> -	struct vm_area_struct *vma;
> -	unsigned int access_flags = 0;
> -	unsigned int fault_flags = FAULT_FLAG_REMOTE;
> -	struct iommu_fault_page_request *prm = &iopf->fault.prm;
> -	enum iommu_page_response_code status = IOMMU_PAGE_RESP_INVALID;
> -
> -	if (!(prm->flags & IOMMU_FAULT_PAGE_REQUEST_PASID_VALID))
> -		return status;
> -
> -	mm = iommu_sva_find(prm->pasid);
> -	if (IS_ERR_OR_NULL(mm))
> -		return status;
> -
> -	mmap_read_lock(mm);
> -
> -	vma = find_extend_vma(mm, prm->addr);
> -	if (!vma)
> -		/* Unmapped area */
> -		goto out_put_mm;
> -
> -	if (prm->perm & IOMMU_FAULT_PERM_READ)
> -		access_flags |= VM_READ;
> -
> -	if (prm->perm & IOMMU_FAULT_PERM_WRITE) {
> -		access_flags |= VM_WRITE;
> -		fault_flags |= FAULT_FLAG_WRITE;
> -	}
> -
> -	if (prm->perm & IOMMU_FAULT_PERM_EXEC) {
> -		access_flags |= VM_EXEC;
> -		fault_flags |= FAULT_FLAG_INSTRUCTION;
> -	}
> -
> -	if (!(prm->perm & IOMMU_FAULT_PERM_PRIV))
> -		fault_flags |= FAULT_FLAG_USER;
> -
> -	if (access_flags & ~vma->vm_flags)
> -		/* Access fault */
> -		goto out_put_mm;
> -
> -	ret = handle_mm_fault(vma, prm->addr, fault_flags, NULL);
> -	status = ret & VM_FAULT_ERROR ? IOMMU_PAGE_RESP_INVALID :
> -		IOMMU_PAGE_RESP_SUCCESS;
> -
> -out_put_mm:
> -	mmap_read_unlock(mm);
> -	mmput(mm);
> -
> -	return status;
> -}
> -
>  static void iopf_handle_group(struct work_struct *work)
>  {
>  	struct iopf_group *group;
> +	struct iommu_domain *domain;
>  	struct iopf_fault *iopf, *next;
>  	enum iommu_page_response_code status = IOMMU_PAGE_RESP_SUCCESS;
>  
>  	group = container_of(work, struct iopf_group, work);
> +	domain = iommu_get_domain_for_dev_pasid(group->dev,
> +			group->last_fault.fault.prm.pasid);
> +	if (!domain || !domain->iopf_handler)
> +		status = IOMMU_PAGE_RESP_INVALID;
>  
>  	list_for_each_entry_safe(iopf, next, &group->faults, list) {
>  		/*
> @@ -139,7 +88,8 @@ static void iopf_handle_group(struct work_struct *work)
>  		 * faults in the group if there is an error.
>  		 */
>  		if (status == IOMMU_PAGE_RESP_SUCCESS)
> -			status = iopf_handle_single(iopf);
> +			status = domain->iopf_handler(&iopf->fault,
> +						      domain->fault_data);
>  
>  		if (!(iopf->fault.prm.flags &
>  		      IOMMU_FAULT_PAGE_REQUEST_LAST_PAGE))
> diff --git a/drivers/iommu/iommu-sva-lib.c b/drivers/iommu/iommu-sva-lib.c
> index 05a7d2f0e46f..ae3595d60f38 100644
> --- a/drivers/iommu/iommu-sva-lib.c
> +++ b/drivers/iommu/iommu-sva-lib.c
> @@ -69,26 +69,6 @@ static int iommu_sva_alloc_pasid(struct mm_struct *mm,
>  	return ret;
>  }
>  
> -/* ioasid_find getter() requires a void * argument */
> -static bool __mmget_not_zero(void *mm)
> -{
> -	return mmget_not_zero(mm);
> -}
> -
> -/**
> - * iommu_sva_find() - Find mm associated to the given PASID
> - * @pasid: Process Address Space ID assigned to the mm
> - *
> - * On success a reference to the mm is taken, and must be released with mmput().
> - *
> - * Returns the mm corresponding to this PASID, or an error if not found.
> - */
> -struct mm_struct *iommu_sva_find(ioasid_t pasid)
> -{
> -	return ioasid_find(&iommu_sva_pasid, pasid, __mmget_not_zero);
> -}
> -EXPORT_SYMBOL_GPL(iommu_sva_find);
> -
>  /*
>   * Get or put an ioas for a shared memory.
>   */
> -- 
> 2.25.1
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
