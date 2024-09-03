Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 701AB1A0BC4
	for <iommu@lists.linux.dev>; Tue,  3 Sep 2024 09:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725356356; cv=none; b=WsTWQF7rMnHIBboVlPWnpmfCjZ/cIwFqq62qJWeeHN5NbqNViPNCrLiEgNp90UHhv0VtHPZD4jBo//I/WpdDVctsI9Hm3G0naAp7gZ432yQE4T9ew5yhd5j/XOPEa6ElVtYJWfV3XeihAa7ZTPginspMfW6UeXCIRhlRet8Cjos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725356356; c=relaxed/simple;
	bh=Roj+Ea7LEvenEhyYiuiVmXINZE+I65g3EEz0Bl+4ooc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=HTlSQqq+BCXYE5gV9PoT9TwMwOMq/++6PA02zm2uInTWuLlSS/uxN9kKa/pci1uEb7mYg+A7aCPUuw58CLTnvC/ylRUV29rzOuOPGYruEQ9DdXjYVeeYj9zaZcuclsGQ96eG4AP9JimHvIkWV8r3HsdG/P5h4Jfud9vvdMCET7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IwA87VLU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IwA87VLU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725356354;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ROekkmcoe+OX/H/SJ0CegmonvJxcYbn0m80zXzGYZLw=;
	b=IwA87VLU+B12aZLCohRZrPV2pic9PLha3G0m5T5TWCcH3QKKC/vMrXUPMlbTsT2neoVRnX
	wOchTASGIpXfEAO4QV67XpxWCZYXTB7HXJRa4AeAXitSpTuMhluM0QA2GBhKVcULC4ZAG1
	etPzDYBqId3NBfUj3zhBQDpJp6A5/VQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-434-EXxoGuU5PDORAVIbsqnb_w-1; Tue, 03 Sep 2024 05:39:11 -0400
X-MC-Unique: EXxoGuU5PDORAVIbsqnb_w-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-42bbd062ac1so37185235e9.0
        for <iommu@lists.linux.dev>; Tue, 03 Sep 2024 02:39:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725356350; x=1725961150;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ROekkmcoe+OX/H/SJ0CegmonvJxcYbn0m80zXzGYZLw=;
        b=fRbcjXp6YqYkGs4S2/7V5JoSZ0et2n1LA+FAoBnb/ctMi37Px6scHeW5xvql3t++jD
         8MFaOw8qMXlHYl7+oC9s2U4fCnwL3FWRt0QDM6nukVVsXk7wDojlOIsdYP5xy4d6Xb7g
         FalqhPYCvRKpzMp9a/o8U6yEYlgTVTV4bhm9KAmaPyz8TxXtZpfupR82V6KIDCw9nyYW
         yIQadO4Mp/6IDN5L+vT5gMRmKHoHm8vCCkyQHcy/4VXspcqQF8A7LnlWlXGI89Zc3n+T
         6MIltxwN8B12BnjKycMFgFUIBhjs5urn5U+6T78GGurJGrVCXN0oHuET57YvkOH7LHr5
         2/iA==
X-Gm-Message-State: AOJu0Yzv3wRz8H47o03/4BQVmXYRZ1IMvFh4rBS9AHT5WCVlilNnqQiR
	JlPXx+TKFeWFKX7QzrkWguwOfrb3+MEYsULWo9VT4ixmDwYCe1QaASWIL2fTH7TTWPiAhL6Kb6V
	qByEPFPt+ylO0KnEFcN2BsJ0+raejl9GrYwo8dkQuRe5lLYduMiOa
X-Received: by 2002:a05:600c:3d0d:b0:426:4f47:6037 with SMTP id 5b1f17b1804b1-42bdc6375abmr66533115e9.19.1725356350124;
        Tue, 03 Sep 2024 02:39:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGmeosf/mJIf4OuBVOC1FXDQtaN47WobnVUFS/lrBzspPK+LAJFhvAiwYTR4QIKkjIzV+Hhfw==
X-Received: by 2002:a05:600c:3d0d:b0:426:4f47:6037 with SMTP id 5b1f17b1804b1-42bdc6375abmr66532735e9.19.1725356349385;
        Tue, 03 Sep 2024 02:39:09 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:441:95c6:9977:c577:f3d1:99e1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42bba57bb20sm142356975e9.4.2024.09.03.02.39.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 02:39:08 -0700 (PDT)
Date: Tue, 3 Sep 2024 05:39:04 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: iommu@lists.linux.dev, Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Bingbu Cao <bingbu.cao@intel.com>, Jason Wang <jasowang@redhat.com>,
	linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
	linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org, sparclinux@vger.kernel.org,
	linux-media@vger.kernel.org, virtualization@lists.linux.dev,
	xen-devel@lists.xenproject.org
Subject: Re: [PATCH 1/2] vdpa_sim: don't select DMA_OPS
Message-ID: <20240903053857-mutt-send-email-mst@kernel.org>
References: <20240828061104.1925127-1-hch@lst.de>
 <20240828061104.1925127-2-hch@lst.de>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20240828061104.1925127-2-hch@lst.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 28, 2024 at 09:10:28AM +0300, Christoph Hellwig wrote:
> vdpa_sim has been fixed to not override the dma_map_ops in commit
> 6c3d329e6486 ("vdpa_sim: get rid of DMA ops"), so don't select the
> symbol and don't depend on HAS_DMA.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
>  drivers/vdpa/Kconfig | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/vdpa/Kconfig b/drivers/vdpa/Kconfig
> index 5265d09fc1c409..b08de3b7706109 100644
> --- a/drivers/vdpa/Kconfig
> +++ b/drivers/vdpa/Kconfig
> @@ -11,8 +11,7 @@ if VDPA
>  
>  config VDPA_SIM
>  	tristate "vDPA device simulator core"
> -	depends on RUNTIME_TESTING_MENU && HAS_DMA
> -	select DMA_OPS
> +	depends on RUNTIME_TESTING_MENU
>  	select VHOST_RING
>  	select IOMMU_IOVA
>  	help
> -- 
> 2.43.0

