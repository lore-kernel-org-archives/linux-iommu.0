Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D18C774079
	for <iommu@lists.linux.dev>; Thu, 30 May 2024 21:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717103130; cv=none; b=AmtX5XIjt4u1tSwXn+mNrZ5MHBDCBs09a3X/Ujl+w1lnEs92uSMjF9fiVxBDidLwuHOlBqlfui1GCbrLFNACo5btz+2SxSgSTAjGgr8/XckKpkDCexcFNvVEvw7/2PnKV+mj4dPfyPkj2+J9GiM/yLqb/bcRolRypwL+JBBSA3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717103130; c=relaxed/simple;
	bh=Wab1ZpjxSP/0gKB2mRfLQf1QYdy5fhanYyy8leNd0UU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=ZKWt7xOInPLNTxLTGDsAPkRqYd/alzCastZXzOzWNPX76uZK1M7zQKUJbtWSbyAqEXM/KFMMEIe/ovJ49358SUWdLCDb6UdEd5gi932bahH2AXNM1csG11YNiyZuatnhgNhV86pPz1m5Go4nf9OTVTz7UfYx4PfCCuwv5B2OZ4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JhweEs17; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JhweEs17"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717103127;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Q2LCriRFRXLIylgT+gTKyTfxSCc/meDMgzalNC625x8=;
	b=JhweEs17hMiX+8zSb4HA9YlbwLOotvX3V5mp1a110Cb1k3BVmCy5I8DCXkuBAqGojI8Vrh
	rtNRhIaCBL8C0BkCYb+nWjvUDqX9Qg12m9/8gkDsujTK8ORWfxh9welsIhCFeHUaOUCyUZ
	9QBFyvy7nX/W65j/Ngn3ydDqIz5a68M=
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com
 [209.85.160.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-76-3kbZda-LP8yt8DLsOPEaSA-1; Thu, 30 May 2024 17:05:24 -0400
X-MC-Unique: 3kbZda-LP8yt8DLsOPEaSA-1
Received: by mail-oa1-f69.google.com with SMTP id 586e51a60fabf-24c6783b8eeso872078fac.2
        for <iommu@lists.linux.dev>; Thu, 30 May 2024 14:05:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717103123; x=1717707923;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q2LCriRFRXLIylgT+gTKyTfxSCc/meDMgzalNC625x8=;
        b=Gt8rVZefkfJYAG7xuMDq+c2hXFONlh/LpBfpRrHp+DDBo12zjCJhcP8EJ4UACUCK3W
         4hQzinLE04ReYuezPXaLOQubNlr6wA77yhzWCG+voR5aPrPwv+JYYj56T/WJduUhWPZB
         RSxDT8Y/wYGzC6YOPjelgd1DFe+nWzObb7+DMHOOU/7APB43jLlGEZn97yRxgAkkvKBG
         g836fi55bqi6pJfbD4jnhg8ymNWYKtrAD2VuVTzFRLCADi805UfICGZjFHxcA7I21ehj
         ew6AmW4m4H9r9nMyCPqPy93RaTZC20MpCkzBvT79zXPrZIvdjo81StxfavdAYr/9NQVw
         Ls5g==
X-Forwarded-Encrypted: i=1; AJvYcCWPqGTxYDt8cHlt/Oa9gtGc3mBgqg+YShzxWhFu/0MjawlDdfJA90FoeWCWCqRZPwIYLc+1bcHUltTxg+k02wQev9W+wH0=
X-Gm-Message-State: AOJu0Yy+Fi9OwcIqcxNOfzXLt9qetj9PVEUPFtRO5ZjFdhwNfWt4yMbp
	oSZwu6rH8Z744j8GVtpOtJg0rQ0BqWCtGZSue8Y5rXZebti5oSuC/qxgfJhK5GRMaINp1sqTr49
	kzvluZANNKj1BH/xtwEV7GngxtIQxU93V0aMZ5o89VGaMvnN2lN1j
X-Received: by 2002:a05:6871:2898:b0:24f:ee25:3639 with SMTP id 586e51a60fabf-2508bddc002mr62916fac.26.1717103123406;
        Thu, 30 May 2024 14:05:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHS43guAvWnbjReVwItT6ybaTTo9jHFyw4D9vxJUSkaNCNMDnbU6q11n3Nb7CVhlCdYsvZ4sQ==
X-Received: by 2002:a05:6871:2898:b0:24f:ee25:3639 with SMTP id 586e51a60fabf-2508bddc002mr62888fac.26.1717103123035;
        Thu, 30 May 2024 14:05:23 -0700 (PDT)
Received: from localhost (ip98-179-76-110.ph.ph.cox.net. [98.179.76.110])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-43ff23fd366sm1747411cf.56.2024.05.30.14.05.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 May 2024 14:05:22 -0700 (PDT)
Date: Thu, 30 May 2024 14:05:21 -0700
From: Jerry Snitselaar <jsnitsel@redhat.com>
To: Dimitri Sivanich <sivanich@hpe.com>
Cc: Yi Zhang <yi.zhang@redhat.com>, "Tian, Kevin" <kevin.tian@intel.com>, 
	Vasant Hegde <vasant.hegde@amd.com>, Baolu Lu <baolu.lu@linux.intel.com>, 
	Joerg Roedel <joro@8bytes.org>, Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, 
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	David Wang <00107082@163.com>, Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>, 
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org, Steve Wahl <steve.wahl@hpe.com>, 
	Russ Anderson <russ.anderson@hpe.com>
Subject: Re: [PATCH] iommu/amd: Fix panic accessing amd_iommu_enable_faulting
Message-ID: <hxv32qgpb57yxweldav35evt2e3hyt2n2rmbjsl7biaje7s4tp@4nyanvqd6su5>
References: <ZljHE/R4KLzGU6vx@hpe.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <ZljHE/R4KLzGU6vx@hpe.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 30, 2024 at 01:36:03PM GMT, Dimitri Sivanich wrote:
> This fixes a bug introduced by commit d74169ceb0d2 ("iommu/vt-d: Allocate
> DMAR fault interrupts locally").  The panic happens when
> amd_iommu_enable_faulting is called from CPUHP_AP_ONLINE_DYN context.
> 
> Fixes: d74169ceb0d2 ("iommu/vt-d: Allocate DMAR fault interrupts locally")
> Signed-off-by: Dimitri Sivanich <sivanich@hpe.com>
> Tested-by: Yi Zhang <yi.zhang@redhat.com>
> ---

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

>  drivers/iommu/amd/init.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
> index a18e74878f68..b02b959d12af 100644
> --- a/drivers/iommu/amd/init.c
> +++ b/drivers/iommu/amd/init.c
> @@ -3353,7 +3353,7 @@ int amd_iommu_reenable(int mode)
>  	return 0;
>  }
>  
> -int __init amd_iommu_enable_faulting(unsigned int cpu)
> +int amd_iommu_enable_faulting(unsigned int cpu)
>  {
>  	/* We enable MSI later when PCI is initialized */
>  	return 0;
> -- 
> 2.35.3

