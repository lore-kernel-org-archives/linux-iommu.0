Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 755672F2B
	for <iommu@lists.linux.dev>; Fri, 11 Nov 2022 16:32:34 +0000 (UTC)
Received: by mail-wr1-f48.google.com with SMTP id h9so7180827wrt.0
        for <iommu@lists.linux.dev>; Fri, 11 Nov 2022 08:32:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=15l/tjkn1n+H5TD0Hk47oWikjwMgVaOYjZFSi1PWwnU=;
        b=UpIiIlgLyGu9n4OAGdeJeyb5r7ol8GD4f1U4jwIbGsZ0ywz7bY1kPkfoeDyhxVC0zC
         yvcFBqdOKgDqTEq+qoMFkzgAVKI7ORUvejrTkdjOLbv5wIjYaU71Xn6rjQsbBkr+bT4H
         ZblTbYUADaAhzddJg6hTvLYdvUn0tMZcqxhLDYY4DjRAa4CwsZbwGIh9kvnnF3ytxkuN
         8RUjJegbDPH71U/kVLps8tm4JlrmdR6xBx/+zmr1FaFO6MXRl2OxExXdW9tkanjPiV0Z
         imfOpsylJSPN8YtqhMdKUlXHirk5WbqHXlMmErRXpjc9pTdXuiYcH0+goAenl/amTr2/
         EKwA==
X-Gm-Message-State: ANoB5pkFoP3KKQZ68wKXGTo8RY0lrTR6aHjUoRpm79qbxEL3cRIgCb1z
	aHE/FWAj1pvzkYG3d8UnXYM=
X-Google-Smtp-Source: AA0mqf526Ay2inaUCYCd70/sGA5iFRHIL1qrPSOWcu2g8ZiAtJ7gmz6MCmuXM6IQ106v6azLuQ7QVw==
X-Received: by 2002:adf:f0cd:0:b0:22e:344a:ec5e with SMTP id x13-20020adff0cd000000b0022e344aec5emr1830279wro.673.1668184352674;
        Fri, 11 Nov 2022 08:32:32 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id bp11-20020a5d5a8b000000b002366eb01e07sm2256397wrb.114.2022.11.11.08.32.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Nov 2022 08:32:32 -0800 (PST)
Date: Fri, 11 Nov 2022 16:32:30 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>,
	tianyu.lan@microsoft.com
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev, mikelley@microsoft.com,
	sunilmut@microsoft.com, wei.liu@kernel.org, kys@microsoft.com,
	Tianyu.Lan@microsoft.com, haiyangz@microsoft.com,
	decui@microsoft.com, dwmw2@infradead.org, joro@8bytes.org,
	will@kernel.org
Subject: Re: [PATCH] iommu/hyper-v: Allow hyperv irq remapping without x2apic
Message-ID: <Y255HhDbwbI/z5bJ@liuwe-devbox-debian-v2>
References: <1668020853-23950-1-git-send-email-nunodasneves@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1668020853-23950-1-git-send-email-nunodasneves@linux.microsoft.com>

Hi Tianyu

On Wed, Nov 09, 2022 at 11:07:33AM -0800, Nuno Das Neves wrote:
> If x2apic is not available, hyperv-iommu skips remapping
> irqs. This breaks root partition which always needs irqs
> remapped.
> 
> Fix this by allowing irq remapping regardless of x2apic,
> and change hyperv_enable_irq_remapping() to return
> IRQ_REMAP_XAPIC_MODE in case x2apic is missing.
> 

Do you remember why it was x2apic only?

We tested this patch on different VM SKUs and it worked fine. I'm just
wondering if there would be some subtle breakages that we couldn't
easily test.

Thanks,
Wei.

> Tested with root and non-root hyperv partitions.
> 
> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
> ---
>  drivers/iommu/Kconfig        | 6 +++---
>  drivers/iommu/hyperv-iommu.c | 7 ++++---
>  2 files changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> index dc5f7a156ff5..cf7433652db0 100644
> --- a/drivers/iommu/Kconfig
> +++ b/drivers/iommu/Kconfig
> @@ -474,13 +474,13 @@ config QCOM_IOMMU
>  	  Support for IOMMU on certain Qualcomm SoCs.
>  
>  config HYPERV_IOMMU
> -	bool "Hyper-V x2APIC IRQ Handling"
> +	bool "Hyper-V IRQ Handling"
>  	depends on HYPERV && X86
>  	select IOMMU_API
>  	default HYPERV
>  	help
> -	  Stub IOMMU driver to handle IRQs as to allow Hyper-V Linux
> -	  guests to run with x2APIC mode enabled.
> +	  Stub IOMMU driver to handle IRQs to support Hyper-V Linux
> +	  guest and root partitions.
>  
>  config VIRTIO_IOMMU
>  	tristate "Virtio IOMMU driver"
> diff --git a/drivers/iommu/hyperv-iommu.c b/drivers/iommu/hyperv-iommu.c
> index e190bb8c225c..abd1826a9e63 100644
> --- a/drivers/iommu/hyperv-iommu.c
> +++ b/drivers/iommu/hyperv-iommu.c
> @@ -123,8 +123,7 @@ static int __init hyperv_prepare_irq_remapping(void)
>  	const struct irq_domain_ops *ops;
>  
>  	if (!hypervisor_is_type(X86_HYPER_MS_HYPERV) ||
> -	    x86_init.hyper.msi_ext_dest_id() ||
> -	    !x2apic_supported())
> +	    x86_init.hyper.msi_ext_dest_id())
>  		return -ENODEV;
>  
>  	if (hv_root_partition) {
> @@ -170,7 +169,9 @@ static int __init hyperv_prepare_irq_remapping(void)
>  
>  static int __init hyperv_enable_irq_remapping(void)
>  {
> -	return IRQ_REMAP_X2APIC_MODE;
> +	if (x2apic_supported())
> +		return IRQ_REMAP_X2APIC_MODE;
> +	return IRQ_REMAP_XAPIC_MODE;
>  }
>  
>  struct irq_remap_ops hyperv_irq_remap_ops = {
> -- 
> 2.25.1
> 
