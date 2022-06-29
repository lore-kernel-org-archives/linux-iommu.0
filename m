Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8925C7B
	for <iommu@lists.linux.dev>; Wed, 29 Jun 2022 09:14:27 +0000 (UTC)
Received: by mail-wr1-f46.google.com with SMTP id i25so15924492wrc.13
        for <iommu@lists.linux.dev>; Wed, 29 Jun 2022 02:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=U+mKfaGXoONCznFgzmYIZny9AKkMWKoWt6b7S8f60RM=;
        b=fEDY3d9nvND9FB+yUl1AlWKqmdRimCwOi50i1qa9A3DKppiVdL0evazSl+CYovnpPb
         +xe7MhtHEIdRd/hU3l/ogn7sAWDlJUBLc392CjdJtrSQfAf0m+yIkjQ5Ga6atX/HRS7q
         yWgmVnPRgemnHBcUGxlhsY3DN9UnUcJt1/h9p3fpOkxCpxOj0Ckew4iqSSylcCqnElDa
         AVau4GSEu7q/4s2ZTilxBRERa7+HplvcEVjMmlivdXoSG5lnUC7moEqfpj1JhEbdYSXx
         6MUxFw9BPh4JT9OYAiLOGKncNm/n7RARaGhuCY/YcqnhEA2h4qe0OikedNdDbvVg1I8b
         JqNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=U+mKfaGXoONCznFgzmYIZny9AKkMWKoWt6b7S8f60RM=;
        b=Titudz09kzagoCsqa6+lXfKNQoSGTzwxjvp84G6X/Iyb9RESIVo8pQBZPY4bpPKE4Z
         pniSihPuvd+5O2AaulJfRqyfXon0DE+z8a2e8+120jU5bvIbLNX21cma4qt+3nOOp6XO
         /5bcyY6AuLqRK2byksoo2Gzh8D5RCmeTYzs34HtW1uFBJxUdhyjxT8Y3mIeCH+LYTW6b
         HTu+sZvCpfH3NgBfsZgQzILgk3W6c1wOsQ5qvieD2EAAUMD5oPI0vxV6cyYGo2KTl0Fv
         XeaVI51UQeNcLdEn5SlXxr84247/AE12umTwIdRN6W87szw7o8CgM/4/uNcxEt4Q9SbF
         buwg==
X-Gm-Message-State: AJIora/FwTPjyYlDfvavb5dNxQrlytukBv9Fd1ywRuxwxezbBvaaLfp2
	Ua7Hz+vHIfOkpl+UHY8Lnffdhw==
X-Google-Smtp-Source: AGRyM1uss6yL9ryGiFhRNXcrE8eBDDu99NbY6sECQMgnEwKtRLT98HuE31fmJMfucgcPw940Fu+20A==
X-Received: by 2002:a5d:4352:0:b0:213:4910:6616 with SMTP id u18-20020a5d4352000000b0021349106616mr2022060wrr.226.1656494065746;
        Wed, 29 Jun 2022 02:14:25 -0700 (PDT)
Received: from myrica (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net. [82.27.106.168])
        by smtp.gmail.com with ESMTPSA id z18-20020a05600c0a1200b0039c45fc58c4sm2440202wmp.21.2022.06.29.02.14.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 02:14:25 -0700 (PDT)
Date: Wed, 29 Jun 2022 10:14:01 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Eric Auger <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, jroedel@suse.de, linux-acpi@vger.kernel.org,
	iommu@lists.linux-foundation.org, rafael@kernel.org,
	lenb@kernel.org, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev
Subject: Re: [PATCH] ACPI: VIOT: Fix ACS setup
Message-ID: <YrwX2U48HOC+UF07@myrica>
References: <20220627125534.1035912-1-eric.auger@redhat.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220627125534.1035912-1-eric.auger@redhat.com>
Message-ID: <20220629091401.aLHCe5fvgXmwTJz0SLKcbaExfP3eGwP3wqQlcwIZqfY@z>

Hi Eric,

On Mon, Jun 27, 2022 at 02:55:34PM +0200, Eric Auger wrote:
> Currently acpi_viot_init() gets called after the pci
> device has been scanned and pci_enable_acs() has been called.
> So pci_request_acs() fails to be taken into account leading
> to wrong single iommu group topologies when dealing with
> multi-function root ports for instance.
> 
> We cannot simply move the acpi_viot_init() earlier, similarly
> as the IORT init because the VIOT parsing relies on the pci
> scan. However we can detect VIOT is present earlier and in
> such a case, request ACS. Introduce a new acpi_viot_early_init()
> routine that allows to call pci_request_acs() before the scan.
> 
> Fixes: 3cf485540e7b ("ACPI: Add driver for the VIOT table")
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Reported-by: Jin Liu <jinl@redhat.com>

Thanks for the fix, the patch makes sense and fixes the issue.

I wondered whether we should keep the logic where we only request ACS if
an IOMMU is found to manage a PCI range, but I can't see any harm in
requesting it regardless (plus there is a precedent with AMD IOMMU).
I could imagine some VMM wanting to only put an IOMMU in front of its MMIO
devices and leave PCI to roam free, but that seems like a stretch.

There is another issue with the existing code, though: we can't call
pci_request_acs() when CONFIG_PCI is disabled because no stub is defined.
Could you wrap the call in an #ifdef?

> ---
>  drivers/acpi/bus.c        |  1 +
>  drivers/acpi/viot.c       | 23 +++++++++++++++++------
>  include/linux/acpi_viot.h |  2 ++
>  3 files changed, 20 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
> index 86fa61a21826..906ad8153fd9 100644
> --- a/drivers/acpi/bus.c
> +++ b/drivers/acpi/bus.c
> @@ -1400,6 +1400,7 @@ static int __init acpi_init(void)
>  
>  	pci_mmcfg_late_init();
>  	acpi_iort_init();
> +	acpi_viot_early_init();
>  	acpi_hest_init();
>  	acpi_ghes_init();
>  	acpi_scan_init();
> diff --git a/drivers/acpi/viot.c b/drivers/acpi/viot.c
> index d2256326c73a..3c1be123e4d6 100644
> --- a/drivers/acpi/viot.c
> +++ b/drivers/acpi/viot.c
> @@ -248,6 +248,23 @@ static int __init viot_parse_node(const struct acpi_viot_header *hdr)
>  	return ret;
>  }
>  
> +/**
> + * acpi_viot_early_init - Test the presence of VIOT and enable ACS
> + *
> + * If the VIOT does exist, ACS must be enabled. This cannot be
> + * done in acpi_viot_init() which is called after the bus scan
> + */
> +void __init acpi_viot_early_init(void)
> +{
> +	acpi_status status;
> +	struct acpi_table_header *hdr;
> +
> +	status = acpi_get_table(ACPI_SIG_VIOT, 0, &hdr);
> +	if (!ACPI_FAILURE(status))
> +		pci_request_acs();
> +	acpi_put_table(hdr);

I'd rather not call acpi_put_table() in case of failure. I know it is
handled but it looks fragile and I couldn't find any other user of
acpi_get_table() doing this.

> +}
> +
>  /**
>   * acpi_viot_init - Parse the VIOT table
>   *
> @@ -319,12 +336,6 @@ static int viot_pci_dev_iommu_init(struct pci_dev *pdev, u16 dev_id, void *data)
>  			epid = ((domain_nr - ep->segment_start) << 16) +
>  				dev_id - ep->bdf_start + ep->endpoint_id;
>  
> -			/*
> -			 * If we found a PCI range managed by the viommu, we're
> -			 * the one that has to request ACS.
> -			 */
> -			pci_request_acs();
> -
>  			return viot_dev_iommu_init(&pdev->dev, ep->viommu,
>  						   epid);
>  		}
> diff --git a/include/linux/acpi_viot.h b/include/linux/acpi_viot.h
> index 1eb8ee5b0e5f..e58d60f8ff2e 100644
> --- a/include/linux/acpi_viot.h
> +++ b/include/linux/acpi_viot.h
> @@ -6,10 +6,12 @@
>  #include <linux/acpi.h>
>  
>  #ifdef CONFIG_ACPI_VIOT
> +void __init acpi_viot_early_init(void);
>  void __init acpi_viot_init(void);
>  int viot_iommu_configure(struct device *dev);
>  #else
>  static inline void acpi_viot_init(void) {}
> +static inline void acpi_viot_early_init(void) {}

nit: different declaration order

Thanks,
Jean


>  static inline int viot_iommu_configure(struct device *dev)
>  {
>  	return -ENODEV;
> -- 
> 2.35.3
> 
