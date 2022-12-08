Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 485C12F3D
	for <iommu@lists.linux.dev>; Thu,  8 Dec 2022 14:08:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1670508527;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JovqNf2S07WftApm6UYOaSP1Pcxu/qWSUUQsQAKBKgM=;
	b=ClqotP6bXCKJfj9rVE+f9PU1A4LlWn+Wq8VMafVpOasXRvnSyyclVgCxwhLK7tJ38Lfmct
	3/i4PZbhNBd2ouNDDhkU/mkcJISQA4lwhRRLTeEXoLxCKsoZkRykomCxnCT9A8CvvZvp45
	uSBWNZNZudfJSPL6w3VrPB/d3/FSDE4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-195-ypG0Bt_9PtmRMYODosaFDg-1; Thu, 08 Dec 2022 09:08:46 -0500
X-MC-Unique: ypG0Bt_9PtmRMYODosaFDg-1
Received: by mail-wr1-f71.google.com with SMTP id o10-20020adfa10a000000b00241f603af8dso291956wro.11
        for <iommu@lists.linux.dev>; Thu, 08 Dec 2022 06:08:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JovqNf2S07WftApm6UYOaSP1Pcxu/qWSUUQsQAKBKgM=;
        b=Nx3x3EJlgqA66x0X4uiBbxga2xlPoLumcMe5pVG/nMGXnXpXxZApdL47KkX4L0u113
         jJRxrOkIdfk7VXr4a/XQ4TgajFTD5pXVhiEj3BQjePXpgMPk4AXgO+WcCUiJ+l1sll+D
         1K11ka4BOu5+1AaPmzii2Gc2mY1fN8JE9FA25BDfySJVKSuF2KbX5qyjBb9xBOWDmEyR
         V3VaG3LJRkJcM87IYW6PmCJmeq6VV6YHhHLbgrIYIgt1oHygIFZMkmbrhAz4lm/pR3v9
         LOFUrVn2DRdfilrTJRSLNKHG5DU6bMrDxRxAdIuIiGI/8yly4fgQon8GhnjqMbCMxBLA
         zdYA==
X-Gm-Message-State: ANoB5plZ3+QmS3qs14AoZXwC26TDsWLL1+UPRKd17zKlI/IbyQKFzXPb
	7vKuwYzF6eJ9Mt02UKJQWcI62TvETTyGptc/SRlWTQutlkkOp0PT5Y+T2VpeAppGxqSjPstl/4V
	hEbkNjDCTR30p4Ww=
X-Received: by 2002:a05:600c:a54:b0:3cf:894f:964b with SMTP id c20-20020a05600c0a5400b003cf894f964bmr1991014wmq.16.1670508525140;
        Thu, 08 Dec 2022 06:08:45 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6Iiy3eQ4XZTEUW2wbEetn35P69+OY2bY4DWna/9VEb7IOQ2UDqSNoO9gKpP5+mJTCuFtYJAw==
X-Received: by 2002:a05:600c:a54:b0:3cf:894f:964b with SMTP id c20-20020a05600c0a5400b003cf894f964bmr1990997wmq.16.1670508524895;
        Thu, 08 Dec 2022 06:08:44 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874? ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
        by smtp.gmail.com with ESMTPSA id c2-20020a05600c0a4200b003cfd4cf0761sm6027048wmq.1.2022.12.08.06.08.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Dec 2022 06:08:43 -0800 (PST)
Message-ID: <1ab9a395-96c5-d805-75b5-40b416f851a7@redhat.com>
Date: Thu, 8 Dec 2022 15:08:42 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Reply-To: eric.auger@redhat.com
Subject: Re: [PATCH 2/3] iommufd: Improve a few unclear bits of code
To: Jason Gunthorpe <jgg@nvidia.com>, iommu@lists.linux.dev
Cc: Binbin Wu <binbin.wu@linux.intel.com>, Kevin Tian <kevin.tian@intel.com>,
 Lixiao Yang <lixiao.yang@intel.com>, Matthew Rosato
 <mjrosato@linux.ibm.com>, Nicolin Chen <nicolinc@nvidia.com>,
 Yi Liu <yi.l.liu@intel.com>
References: <2-v1-0362a1a1c034+98-iommufd_fixes1_jgg@nvidia.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <2-v1-0362a1a1c034+98-iommufd_fixes1_jgg@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 12/7/22 21:44, Jason Gunthorpe wrote:
> Correct a few items noticed late in review:
>
>  - We should assert that the math in batch_clear_carry() doesn't underflow
>
>  - user->locked should be -1 not 0 sicne we just did mmput
>
>  - npages should not have been recalculated, it already has that value
>
> No functional change.
>
> Fixes: 8d160cd4d506 ("iommufd: Algorithms for PFN storage")
> Reported-by: Binbin Wu <binbin.wu@linux.intel.com>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric
> ---
>  drivers/iommu/iommufd/pages.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/iommu/iommufd/pages.c b/drivers/iommu/iommufd/pages.c
> index fccdba782cb699..c771772296485f 100644
> --- a/drivers/iommu/iommufd/pages.c
> +++ b/drivers/iommu/iommufd/pages.c
> @@ -289,6 +289,10 @@ static void batch_clear_carry(struct pfn_batch *batch, unsigned int keep_pfns)
>  	if (!keep_pfns)
>  		return batch_clear(batch);
>  
> +	if (IS_ENABLED(CONFIG_IOMMUFD_TEST))
> +		WARN_ON(!batch->end ||
> +			batch->npfns[batch->end - 1] < keep_pfns);
> +
>  	batch->total_pfns = keep_pfns;
>  	batch->npfns[0] = keep_pfns;
>  	batch->pfns[0] = batch->pfns[batch->end - 1] +
> @@ -723,7 +727,7 @@ static void pfn_reader_user_destroy(struct pfn_reader_user *user,
>  			mmap_read_unlock(pages->source_mm);
>  		if (pages->source_mm != current->mm)
>  			mmput(pages->source_mm);
> -		user->locked = 0;
> +		user->locked = -1;
>  	}
>  
>  	kfree(user->upages);
> @@ -810,7 +814,6 @@ static int incr_user_locked_vm(struct iopt_pages *pages, unsigned long npages)
>  
>  	lock_limit = task_rlimit(pages->source_task, RLIMIT_MEMLOCK) >>
>  		     PAGE_SHIFT;
> -	npages = pages->npinned - pages->last_npinned;
>  	do {
>  		cur_pages = atomic_long_read(&pages->source_user->locked_vm);
>  		new_pages = cur_pages + npages;

