Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3213DC433F5
	for <iommu@archiver.kernel.org>; Mon, 21 Mar 2022 11:39:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id DF46A60EBD;
	Mon, 21 Mar 2022 11:39:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id w4OghCbeUDHU; Mon, 21 Mar 2022 11:39:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 54B5460E9A;
	Mon, 21 Mar 2022 11:39:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1E70AC001A;
	Mon, 21 Mar 2022 11:39:46 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 707D0C000B
 for <iommu@lists.linux-foundation.org>; Mon, 21 Mar 2022 11:39:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4B66C408A2
 for <iommu@lists.linux-foundation.org>; Mon, 21 Mar 2022 11:39:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id du7_VAFnK56S for <iommu@lists.linux-foundation.org>;
 Mon, 21 Mar 2022 11:39:43 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 47A634089F
 for <iommu@lists.linux-foundation.org>; Mon, 21 Mar 2022 11:39:43 +0000 (UTC)
Received: by mail-ej1-x62a.google.com with SMTP id qa43so29125932ejc.12
 for <iommu@lists.linux-foundation.org>; Mon, 21 Mar 2022 04:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=5rRJEBXQHKgE93vQKG9WozY1mnQbw8HXi3zoT00TbKk=;
 b=oSJ8d8CXIFmfnslydpJfmVjsCjtdX7hX31Y9B6LtbThEgE6sDlvLczK0ElLNpK4aVO
 fmUi35aFFaxyaIbuca4iFxhwDv9lYwXC3WkXJlo+9sk8WaFNaI8VZTK66JyiEFAneH3u
 EEQtbO1UZPBRWnGuyWCGNKwl20dq5+uwB22k9k02vaglodtbdRtIUtVLFG2A03rBAups
 dDDusP9ArG2rcP2ZyvJNdHjoLj5Pi0GB5E1acuK37D5nd3+BZ/PCEYjF2ZeHQzEL+Frn
 PIkIeTDuXuns1TZkWYSykvEc93vl9oDwIbHGGLD8hGILgN+5C96lPaMpIdglLMWdZaLb
 99rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=5rRJEBXQHKgE93vQKG9WozY1mnQbw8HXi3zoT00TbKk=;
 b=OxmkPEuPquBx1IHmFFkVTwrdnUJa8ddzXzowiIsD9VT8yRf4eFXYhkV07jY2FvEPxz
 otR7SOCNphEfbBdsNbGOD1YfiVL3Ck6hTr7ept/T8ZJO0kXHTuBFykwBXT0IpmEXzP2q
 5iBvYyY7ZZcimHacyQk22oOi104YIZccd/l/3eRPsl+z2IeExXKlbhJ2uKiE81r3dL8n
 Mh/h5TVogiyLrH2JLwILSStfdXxFCY8Rsj6L5LwvjtOXpqdWeY6JzoqKSPN54JKsfqEs
 pqHJUMkpoApF1UwDRs+qvdfpSl3gtRASv2zNBcnAWOHstkX0AVFRqj80w2fdIHplpstH
 D4dQ==
X-Gm-Message-State: AOAM532HuDXVwnWEG4+mbMjrRYKj9AxDdt9RQMZ3F55TIiCIqtvd1ac9
 ZJJITpQZJGLqB+zGgABauKU5gQ==
X-Google-Smtp-Source: ABdhPJzXjkZnfa+WkCg4R2ItjOAy3HIcdXwUEFx2MgsfG2GjUyDfJU0F9pBIsCP61lPPH8hFndVWdw==
X-Received: by 2002:a17:906:4443:b0:6cf:6a7d:5f9b with SMTP id
 i3-20020a170906444300b006cf6a7d5f9bmr19977218ejp.12.1647862781388; 
 Mon, 21 Mar 2022 04:39:41 -0700 (PDT)
Received: from myrica (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net.
 [82.27.106.168]) by smtp.gmail.com with ESMTPSA id
 a102-20020a509eef000000b0041614c8f79asm7581597edf.88.2022.03.21.04.39.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Mar 2022 04:39:41 -0700 (PDT)
Date: Mon, 21 Mar 2022 11:39:16 +0000
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH RFC 10/11] iommu: Make IOPF handling framework generic
Message-ID: <Yjhj5F0fUWRRKh3v@myrica>
References: <20220320064030.2936936-1-baolu.lu@linux.intel.com>
 <20220320064030.2936936-11-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220320064030.2936936-11-baolu.lu@linux.intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>, Ashok Raj <ashok.raj@intel.com>,
 Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org,
 Christoph Hellwig <hch@infradead.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 iommu@lists.linux-foundation.org, Jacob jun Pan <jacob.jun.pan@intel.com>,
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

On Sun, Mar 20, 2022 at 02:40:29PM +0800, Lu Baolu wrote:
> The existing IOPF handling framework only handles the I/O page faults for
> SVA. Ginven that we are able to link iommu domain with each I/O page fault,
> we can now make the I/O page fault handling framework more general for
> more types of page faults.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  include/linux/iommu.h         |  4 +++
>  drivers/iommu/io-pgfault.c    | 67 ++++++-----------------------------
>  drivers/iommu/iommu-sva-lib.c | 59 ++++++++++++++++++++++++++++++
>  3 files changed, 73 insertions(+), 57 deletions(-)
> 
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 803e7b07605e..11c65a7bed88 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -50,6 +50,8 @@ struct iommu_dma_cookie;
>  typedef int (*iommu_fault_handler_t)(struct iommu_domain *,
>  			struct device *, unsigned long, int, void *);
>  typedef int (*iommu_dev_fault_handler_t)(struct iommu_fault *, void *);
> +typedef enum iommu_page_response_code (*iommu_domain_iopf_handler_t)
> +			(struct iommu_fault *, void *);
>  
>  struct iommu_domain_geometry {
>  	dma_addr_t aperture_start; /* First address that can be mapped    */
> @@ -101,6 +103,8 @@ struct iommu_domain {
>  	struct iommu_domain_geometry geometry;
>  	struct iommu_dma_cookie *iova_cookie;
>  	struct mm_struct *sva_cookie;
> +	iommu_domain_iopf_handler_t fault_handler;
> +	void *fault_data;
>  };
>  
>  static inline bool iommu_is_dma_domain(struct iommu_domain *domain)
> diff --git a/drivers/iommu/io-pgfault.c b/drivers/iommu/io-pgfault.c
> index 1df8c1dcae77..dad0e40cd8d2 100644
> --- a/drivers/iommu/io-pgfault.c
> +++ b/drivers/iommu/io-pgfault.c
> @@ -69,62 +69,6 @@ static int iopf_complete_group(struct device *dev, struct iopf_fault *iopf,
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
> @@ -134,12 +78,21 @@ static void iopf_handle_group(struct work_struct *work)
>  	group = container_of(work, struct iopf_group, work);
>  
>  	list_for_each_entry_safe(iopf, next, &group->faults, list) {
> +		struct iommu_domain *domain;
> +
> +		domain = iommu_get_domain_for_dev_pasid(group->dev,
> +							iopf->fault.prm.pasid);

Do we have a guarantee that the domain is not freed while we handle the
fault?  We could prevent unbind() while there are pending faults on this
bond. But a refcount on SVA domains could defer freeing, and would also
help with keeping the semantics where bind() returns a single refcounted
bond for any {dev, mm}.

Given that this path is full of circular locking pitfalls, and to keep the
fault handler efficient (well, at least not make it worse), we should
probably keep a getter like iommu_sva_find() that does not require
locking.

> +
> +		if (!domain || !domain->fault_handler)
> +			status = IOMMU_PAGE_RESP_INVALID;
> +
>  		/*
>  		 * For the moment, errors are sticky: don't handle subsequent
>  		 * faults in the group if there is an error.
>  		 */
>  		if (status == IOMMU_PAGE_RESP_SUCCESS)
> -			status = iopf_handle_single(iopf);
> +			status = domain->fault_handler(&iopf->fault,
> +						       domain->fault_data);

If we make this a direct call and only use a light getter for the
PASID->mm lookup we don't need to look at the domain at all. Or are you
planning to add external fault handlers?

>  
>  		if (!(iopf->fault.prm.flags &
>  		      IOMMU_FAULT_PAGE_REQUEST_LAST_PAGE))
> diff --git a/drivers/iommu/iommu-sva-lib.c b/drivers/iommu/iommu-sva-lib.c
> index 47cf98e661ff..01fa8096bd02 100644
> --- a/drivers/iommu/iommu-sva-lib.c
> +++ b/drivers/iommu/iommu-sva-lib.c
> @@ -87,6 +87,63 @@ static struct iommu_domain *iommu_sva_domain_alloc(struct device *dev)
>  	return domain;
>  }
>  
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
> +	mm = domain->sva_cookie;
> +	if (IS_ERR_OR_NULL(mm))
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

mmget_not_zero() is missing since iommu_sva_find() is gone. I'm guessing
we still need it in case the process dies

Thanks,
Jean

> +
> +	return status;
> +}
> +
>  /**
>   * iommu_sva_bind_device() - Bind a process address space to a device
>   * @dev: the device
> @@ -124,6 +181,8 @@ iommu_sva_bind_device(struct device *dev, struct mm_struct *mm, void *drvdata)
>  		goto out;
>  	}
>  	domain->sva_cookie = mm;
> +	domain->fault_handler = iommu_sva_handle_iopf;
> +	domain->fault_data = domain;
>  
>  	ret = iommu_attach_device_pasid(domain, dev, mm->pasid);
>  	if (ret)
> -- 
> 2.25.1
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
