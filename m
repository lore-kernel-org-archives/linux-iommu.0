Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8824433F5
	for <iommu@lists.linux.dev>; Thu, 29 Jun 2023 16:51:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1688057479;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=652dHDO0oI2/WZEBRqfU9KnnRcvhs26hZ9UfWs2k+qc=;
	b=GW89sC8Nf35J0GoM1vI2NO+Xo6VEOGHSvbK3XqVVOTTzCjzETuw5GG8Kp2NOlbzHNQb32X
	trIKaoBUVonZOIcj5tRNASSlwyZvtudLBe1h8QV4gt6fOEnqYm1nE8EpPLb7AAhNxglBOx
	y8BxTKOJOgc8uJY95yx5Q/gpHw1ol88=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-481-15gVRv76P42Z4wy0PDXW7Q-1; Thu, 29 Jun 2023 12:51:18 -0400
X-MC-Unique: 15gVRv76P42Z4wy0PDXW7Q-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-62e85844711so9819466d6.2
        for <iommu@lists.linux.dev>; Thu, 29 Jun 2023 09:51:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688057477; x=1690649477;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=652dHDO0oI2/WZEBRqfU9KnnRcvhs26hZ9UfWs2k+qc=;
        b=eZkMrCNO0vMGq9Ghm+ScnCn4XnZQ7ETNF4J86HBOq/DMGWemLnvPmDtgqIrQGc/SRr
         IGMau60lFRjta6sY8dVOPO23gdn+XAg70rG/msYH+ybF5Wl7Aufe4g+QClwy7Y4uWLdl
         FE3l6wIs9OiWiHtKpOMEiAYAumZQewzb6fiLSjkhcgHkgHTv0LDA9iirTemHx/VydANM
         h7FvF/KAWFMBPEpODK4sxVl5k3A7Kr1OUv4EyIQOOHEIAHn4TAuxIt02BjrDIJaRT4DO
         jQA3YFZynB9098aovCucrUvtq71jhJ6ws0BlKkPyIz1+LsUiHKjTUzuHH/RdCUYXwWj3
         nLxQ==
X-Gm-Message-State: ABy/qLbjmfAt36PA4J+VvYTky5uNsQ9460DYooNmEJOgnJYvfWvRgaKS
	9TwmALQAHZvAPZyTgtL8SgD06Kp9jQ7iEZjC972AxsNlt9E7rPKaphjWhQIEJEty+3EY7amJZSw
	IuUezAzQVOxzD6Ec=
X-Received: by 2002:ad4:5ae8:0:b0:626:33bb:3fd3 with SMTP id c8-20020ad45ae8000000b0062633bb3fd3mr265820qvh.19.1688057477589;
        Thu, 29 Jun 2023 09:51:17 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGOO2kizogdNRwaCRuj29fCIjoHnAbFlPRmury3mnsSPF8W+pVi2X6dBjrHjjJMHhhivwvYOQ==
X-Received: by 2002:ad4:5ae8:0:b0:626:33bb:3fd3 with SMTP id c8-20020ad45ae8000000b0062633bb3fd3mr265809qvh.19.1688057477333;
        Thu, 29 Jun 2023 09:51:17 -0700 (PDT)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id f10-20020ad4558a000000b006300722883fsm7150447qvx.33.2023.06.29.09.51.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jun 2023 09:51:16 -0700 (PDT)
Date: Thu, 29 Jun 2023 09:51:15 -0700
From: Jerry Snitselaar <jsnitsel@redhat.com>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com
Subject: Re: [PATCH 3/3] iommu/amd: Enable PPR/GA interrupt after interrupt
 handler setup
Message-ID: <6xjislc5wsnedweivgtm27g5waqewfj5rmmywr2kzbm4optk2i@dr63xprtxfos>
References: <20230628054554.6131-1-vasant.hegde@amd.com>
 <20230628054554.6131-4-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20230628054554.6131-4-vasant.hegde@amd.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 28, 2023 at 05:45:54AM +0000, Vasant Hegde wrote:
> Current code enables PPR and GA interrupts before setting up the
> interrupt handler (in state_next()). Make sure interrupt handler
> is in place before enabling these interrupt.
> 
> amd_iommu_enable_interrupts() gets called in normal boot, kdump as well
> as in suspend/resume path. Hence moving interrupt enablement to this
> function works fine.
> 
> Reviewed-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

> ---
>  drivers/iommu/amd/init.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
> index f26c077eb9ea..45efb7e5d725 100644
> --- a/drivers/iommu/amd/init.c
> +++ b/drivers/iommu/amd/init.c
> @@ -2943,8 +2943,6 @@ static void enable_iommus_vapic(void)
>  static void enable_iommus(void)
>  {
>  	early_enable_iommus();
> -	enable_iommus_vapic();
> -	enable_iommus_v2();
>  }
>  
>  static void disable_iommus(void)
> @@ -3208,6 +3206,13 @@ static int amd_iommu_enable_interrupts(void)
>  			goto out;
>  	}
>  
> +	/*
> +	 * Interrupt handler is ready to process interrupts. Enable
> +	 * PPR and GA log interrupt for all IOMMUs.
> +	 */
> +	enable_iommus_vapic();
> +	enable_iommus_v2();
> +
>  out:
>  	return ret;
>  }
> @@ -3287,8 +3292,6 @@ static int __init state_next(void)
>  		register_syscore_ops(&amd_iommu_syscore_ops);
>  		ret = amd_iommu_init_pci();
>  		init_state = ret ? IOMMU_INIT_ERROR : IOMMU_PCI_INIT;
> -		enable_iommus_vapic();
> -		enable_iommus_v2();
>  		break;
>  	case IOMMU_PCI_INIT:
>  		ret = amd_iommu_enable_interrupts();
> -- 
> 2.31.1
> 

