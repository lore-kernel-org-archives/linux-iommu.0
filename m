Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FA0D1FD1
	for <iommu@lists.linux.dev>; Mon, 10 Oct 2022 14:33:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1665412393;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=p0fRFJAdAFUAuGAQ/I0Ni1IMy6KgVcr8obOryEi1qB8=;
	b=iYF8WOU6MBO7PaQ1Ed7C3NmgEYcWV6t98hZTo/GhlqLKwx4eMs4BfSTkHXU9cHMwC/9ApG
	lEwC9btdVDKPLIfEYvfQDA2Q7BH+2fGe6BHnufXWFC4lgLlvqMbl8SF2TTqjM7NyeTkE8M
	b6mKu7CTsu76vBSG9j8sPcVxbffm0Q8=
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com
 [209.85.160.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-220-gaMq4fylPZmQJn5PZslcww-1; Mon, 10 Oct 2022 10:33:12 -0400
X-MC-Unique: gaMq4fylPZmQJn5PZslcww-1
Received: by mail-oa1-f69.google.com with SMTP id 586e51a60fabf-132b6ed45b3so5256070fac.2
        for <iommu@lists.linux.dev>; Mon, 10 Oct 2022 07:33:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p0fRFJAdAFUAuGAQ/I0Ni1IMy6KgVcr8obOryEi1qB8=;
        b=ujPWD3a+fDOC0q6nKDUmF0/wtq+RxxkaGA7F30FCUDHJpb1hR5sjTJHB67tXtYkO7m
         9j+7wUtB4HVtHJHHX49B4+dZ28WfzWkVkh8F34lo4yvrntAI/Vaih4cgwTlWgRC3IH7x
         YKV72ZHYsFZrPNHGc1oq0sjE7vqvzjye6trxmv79flWgL3qd/oDWAdjsOEdjwH87eWy8
         k5gLOGRT1tjb1goto+MgHHzA8Hbf6Bl6eHIWpF+V/fNYKdZnHr2fV37M+29Batabqztp
         vvoeALyMp7sQ2Ai+GG8W/jBHM29TKA97Far33Pwo3KAd94ShHAWNO9MEYbEHSxFWxdFE
         3gUA==
X-Gm-Message-State: ACrzQf3JjmLctWVxR5zCQagIlYb/lPGq1JwhIHy0xHDqU2MCWVu+5HYr
	8W1whuwLY2XA3CpzhmNK7RGWd2Bx3YlRsIcbAL0M7opVPNRSIAASDjB5eoMkwF6b55xwWbQn+RV
	oEabaXrAt4iLMBFk=
X-Received: by 2002:a05:6830:33e1:b0:655:e771:f572 with SMTP id i1-20020a05683033e100b00655e771f572mr8444994otu.245.1665412391361;
        Mon, 10 Oct 2022 07:33:11 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM54DQDpetaOotRbUE06O9r7QYXvmMkojLsw/9Q3/76RQLMTAjat7qte6rDhtkVbQ1+y03CLxg==
X-Received: by 2002:a05:6830:33e1:b0:655:e771:f572 with SMTP id i1-20020a05683033e100b00655e771f572mr8444979otu.245.1665412391133;
        Mon, 10 Oct 2022 07:33:11 -0700 (PDT)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id z6-20020aca6706000000b00353fe4fb4casm4324793oix.48.2022.10.10.07.33.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Oct 2022 07:33:10 -0700 (PDT)
Date: Mon, 10 Oct 2022 07:33:09 -0700
From: Jerry Snitselaar <jsnitsel@redhat.com>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH] iommu/vt-d: Clean up si_domain in the init_dmars() error
 path
Message-ID: <20221010143309.ed5pnkw2stjb26sc@cantor>
References: <20221010065608.281860-1-jsnitsel@redhat.com>
 <35cf84fb-7672-671a-4354-0fb66bd2f8e7@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <35cf84fb-7672-671a-4354-0fb66bd2f8e7@linux.intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Oct 10, 2022 at 07:32:43PM +0800, Baolu Lu wrote:
> On 2022/10/10 14:56, Jerry Snitselaar wrote:
> > A splat from kmem_cache_destroy() was seen with a kernel prior to
> > commit ee2653bbe89d ("iommu/vt-d: Remove domain and devinfo mempool")
> > when there was a failure in init_dmars(), because the iommu_domain
> > cache still had objects. While the mempool code is now gone, there
> > still is a leak of the si_domain memory if init_dmars() fails. So
> > clean up si_domain in the init_dmars() error path.
> > 
> > Cc: Lu Baolu <baolu.lu@linux.intel.com>
> > Cc: Joerg Roedel <joro@8bytes.org>
> > Cc: Will Deacon <will@kernel.org>
> > Cc: Robin Murphy <robin.murphy@arm.com>
> > Fixes: 86080ccc223a ("iommu/vt-d: Allocate si_domain in init_dmars()")
> > Signed-off-by: Jerry Snitselaar <jsnitsel@redhat.com>
> > ---
> >   drivers/iommu/intel/iommu.c | 2 ++
> >   1 file changed, 2 insertions(+)
> > 
> > diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> > index 31bc50e538a3..8f1f80a4d0c5 100644
> > --- a/drivers/iommu/intel/iommu.c
> > +++ b/drivers/iommu/intel/iommu.c
> > @@ -3042,6 +3042,8 @@ static int __init init_dmars(void)
> >   		disable_dmar_iommu(iommu);
> >   		free_dmar_iommu(iommu);
> >   	}
> > +	if (si_domain)
> > +		domain_exit(si_domain);
> 
> Thank you for the patch.
> 
> Above requires si_domain to be NULL or a valid pointer. So do you also
> need to add the following change?
> 
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -2410,6 +2410,7 @@ static int __init si_domain_init(int hw)
> 
>         if (md_domain_init(si_domain, DEFAULT_DOMAIN_ADDRESS_WIDTH)) {
>                 domain_exit(si_domain);
> +               si_domain = NULL;
>                 return -EFAULT;
>         }
> 
> Best regards,
> baolu

Hi Baolu,

Yes. I think should add it after the domain_exit() call I added as well.

Regards,
Jerry

