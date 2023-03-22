Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B88E23AD
	for <iommu@lists.linux.dev>; Wed, 22 Mar 2023 10:04:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1679479494;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UlzXqLaiFJqutr/ifAilPZ+K+vBBAuY2KbY33ds/cHU=;
	b=QuHYXuG1PoClu0Ec2gQNxWp1LFSbxz37snYBTgWBsDysLGluAK70bhGXRD5gYUVSPgIzwh
	w+66xqAPpMJvGB8ZWrAwF+JWKdVxiw8NcZvdwR/KPgzyfp26VV+BgEXWCU1mc6HVm35U8y
	2ORNo0hb2GTZzDzFRrjoQ08GgAm4MlQ=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-563-7S9vxbtQMPOQgZMzewmtvA-1; Wed, 22 Mar 2023 06:04:52 -0400
X-MC-Unique: 7S9vxbtQMPOQgZMzewmtvA-1
Received: by mail-qt1-f199.google.com with SMTP id t22-20020ac86a16000000b003bd1c0f74cfso10549017qtr.20
        for <iommu@lists.linux.dev>; Wed, 22 Mar 2023 03:04:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679479492;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UlzXqLaiFJqutr/ifAilPZ+K+vBBAuY2KbY33ds/cHU=;
        b=l8ltpxo7i6j3686+BJYbUr8jTa0BpcUNrGceZjGgWfTqni8iOt/lxQDOGJM735ubd4
         u/09BpktKi1FOOmdEnAH/YX+n7Aq9W9Wn9VCdTkjPFg9HV6ZLmY2vNLhRwL25JnSGScK
         cnrisY2cxyXeWZSOAW4La6gbF4MGV/oVOj1yBEFnwtp2cwF651Ai2i3CAdjMGQvZCJJc
         94oebV3+zzfRRiKv2cOU1g6MsLw0/plO+UnjY1H7qeo1e+6UYSAl+Iak2uexrZfvDlTJ
         ibfg2GmsScMimOxSQyn2XmV5rG44Nm8mIxNbRr/eKU284mj+TEePqvlS/x9X+SDjhd1l
         2oxQ==
X-Gm-Message-State: AO0yUKXRak60RCEGqWoJpfYhi77z+tgavRiMNSfifq4DavQ4bIsFNH9k
	dCo2NwsHO1ot9WEIsJvC2mvz7J8itef3C7tKrKhq5G1LFHBS8uyieIXcGDMjdw+YgqTQeRRAQ92
	UYPtYXUwmXHC9qGY=
X-Received: by 2002:ac8:4e83:0:b0:3bb:88e2:7625 with SMTP id 3-20020ac84e83000000b003bb88e27625mr4875205qtp.24.1679479492326;
        Wed, 22 Mar 2023 03:04:52 -0700 (PDT)
X-Google-Smtp-Source: AK7set+MdvA2FH9NCy5hSRE5kdbgRKa8XU3K3oS6KEMykktU5okAu5JCYZ0efXr+GMZF3/gdAkmxJg==
X-Received: by 2002:ac8:4e83:0:b0:3bb:88e2:7625 with SMTP id 3-20020ac84e83000000b003bb88e27625mr4875177qtp.24.1679479492048;
        Wed, 22 Mar 2023 03:04:52 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874? ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
        by smtp.gmail.com with ESMTPSA id w8-20020a05620a148800b0073bb0ef3a8esm11009302qkj.21.2023.03.22.03.04.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Mar 2023 03:04:51 -0700 (PDT)
Message-ID: <1a227cc4-217b-01aa-ecee-9819160d9a44@redhat.com>
Date: Wed, 22 Mar 2023 11:04:48 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Reply-To: eric.auger@redhat.com
Subject: Re: [RESEND PATCH] ACPI: VIOT: Initialize the correct IOMMU fwspec
To: Jean-Philippe Brucker <jean-philippe@linaro.org>, rafael@kernel.org
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org, iommu@lists.linux.dev,
 linux-pci@vger.kernel.org, helgaas@kernel.org
References: <20230320180528.281755-1-jean-philippe@linaro.org>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20230320180528.281755-1-jean-philippe@linaro.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Jean,

On 3/20/23 19:05, Jean-Philippe Brucker wrote:
> When setting up DMA for a PCI device, we need to initialize its
> iommu_fwspec with all possible alias RIDs (such as PCI bridges). To do
> this we use pci_for_each_dma_alias() which calls
> viot_pci_dev_iommu_init(). This function incorrectly initializes the
> fwspec of the bridge instead of the device being configured. Fix it by
> passing the original device as context to pci_for_each_dma_alias().
>
> Fixes: 3cf485540e7b ("ACPI: Add driver for the VIOT table")
> Reported-by: Eric Auger <eric.auger@redhat.com>
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Tested-by: Eric Auger <eric.auger@redhat.com>

With this patch the pcie-to-pci bridge is assigned an iommu group.
The iommu group topology is not yet correct (ie. end points downstream
to the pcie-to-pci bridge are put in a separate iommu group) however
this is not related to that patch and not supposed to be fixed here
(https://lore.kernel.org/all/4fead092-1058-198a-b430-3dee0fffcd51@arm.com/)

Thanks

Eric

> ---
> This fixes issue (1) reported here:
> https://lore.kernel.org/all/Y8qzOKm6kvhGWG1T@myrica/
>
> resend: Added linux-pci list
> ---
>  drivers/acpi/viot.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/acpi/viot.c b/drivers/acpi/viot.c
> index ed752cbbe636..c8025921c129 100644
> --- a/drivers/acpi/viot.c
> +++ b/drivers/acpi/viot.c
> @@ -328,6 +328,7 @@ static int viot_pci_dev_iommu_init(struct pci_dev *pdev, u16 dev_id, void *data)
>  {
>  	u32 epid;
>  	struct viot_endpoint *ep;
> +	struct device *aliased_dev = data;
>  	u32 domain_nr = pci_domain_nr(pdev->bus);
>  
>  	list_for_each_entry(ep, &viot_pci_ranges, list) {
> @@ -338,7 +339,7 @@ static int viot_pci_dev_iommu_init(struct pci_dev *pdev, u16 dev_id, void *data)
>  			epid = ((domain_nr - ep->segment_start) << 16) +
>  				dev_id - ep->bdf_start + ep->endpoint_id;
>  
> -			return viot_dev_iommu_init(&pdev->dev, ep->viommu,
> +			return viot_dev_iommu_init(aliased_dev, ep->viommu,
>  						   epid);
>  		}
>  	}
> @@ -372,7 +373,7 @@ int viot_iommu_configure(struct device *dev)
>  {
>  	if (dev_is_pci(dev))
>  		return pci_for_each_dma_alias(to_pci_dev(dev),
> -					      viot_pci_dev_iommu_init, NULL);
> +					      viot_pci_dev_iommu_init, dev);
>  	else if (dev_is_platform(dev))
>  		return viot_mmio_dev_iommu_init(to_platform_device(dev));
>  	return -ENODEV;

