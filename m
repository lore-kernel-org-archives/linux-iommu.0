Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5595512B91
	for <iommu@lists.linux.dev>; Tue,  8 Aug 2023 15:39:49 +0000 (UTC)
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-6bca3311b4fso4668197a34.0
        for <iommu@lists.linux.dev>; Tue, 08 Aug 2023 08:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1691509188; x=1692113988;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Vu3bTxseaRwMWXlMHy3r1Fli+PpGrxR6vwwX/P/G/ns=;
        b=R7SOM9RGjCyr3OYzJC7lModTXlGUhMSHcd6VN9F7SVTHvcXxMq/FCfk0cMYV0tD50G
         7CjPYzMTyiQN2+I1c7vlCjlnd8kW5HcXdWBBnFAUC+X9xXwi3msQ5aGoOgONcQvECU5l
         L2n1TNUtbZjHM1tsDxl3JsofvnDAEnzOG3QScqwI50z/QwBXERYFH42shqCbcKQoXR7S
         O8xIrlIJRgb9Cgc96WBX3whRq6DjIk05GkE6HCCU6WkwZTyQOcpcNr85PMyycAoCxuLX
         gzU6tgaR01OtbTX735ZQ/Ui1i/jXF/QJHsTEMbJ/J7E3rkgZw4KiAtgZgsGA+KwZ9Bwm
         o3Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691509188; x=1692113988;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vu3bTxseaRwMWXlMHy3r1Fli+PpGrxR6vwwX/P/G/ns=;
        b=b7TmYDf14LU8YuDPngfGyJY8sm81dnQfYSsoVylIuO9DINKlvlw09wybxPTQtFiWpG
         pOE1/UPd6e57ZxjKx+B1ul7CPCNlxybIM9JSJ9rptQrbArUbbElRJKBNgO/7hoiWSkzQ
         DW/qA/q0hNohglvR9fNAS+8ASDE4008c3pxBeI3KIIEh+6D1KjrWq7gww2WCfWmRUt07
         OCtVs6QCYN+uRKZ8Sq0U1zcT3f5nsoLkyX0FKSqDhTLfKno0o4DaVTGA/dti1FEuCSNR
         niDhJnJhT6xzms5L1t7YHRB7wQmmGkn/oc4zqdTGwPqNDs5PWvZbi3tT381PaOzuqjBI
         TAcg==
X-Gm-Message-State: AOJu0YzjX7Lfw2dyb715d8e1IWJ0OaRQrMn1/ZAQp/n+12VbnI2hzR/8
	3O8ZT/iRXaCj5GXmDfUCy5TFMw==
X-Google-Smtp-Source: AGHT+IE8mAYysqZZt3qJbJutJQ8hS+sdtbNnAIZ8tCetgxPD62RyGukSAj8g1G2yjhrKrIRUpQNdBw==
X-Received: by 2002:a05:6870:9686:b0:1b0:218b:8acc with SMTP id o6-20020a056870968600b001b0218b8accmr13915945oaq.7.1691509188152;
        Tue, 08 Aug 2023 08:39:48 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-25-194.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.25.194])
        by smtp.gmail.com with ESMTPSA id g1-20020a0caac1000000b0062629cbff11sm3762749qvb.11.2023.08.08.08.39.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 08:39:47 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1qTOoF-004dQl-5k;
	Tue, 08 Aug 2023 12:39:47 -0300
Date: Tue, 8 Aug 2023 12:39:47 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
	wei.huang2@amd.com, jsnitsel@redhat.com
Subject: Re: [PATCH 06/11] iommu/amd: Refactor helper function for attaching
 / detaching device
Message-ID: <ZNJhw8RRvJZ+R61y@ziepe.ca>
References: <20230808100232.5977-1-vasant.hegde@amd.com>
 <20230808100232.5977-7-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230808100232.5977-7-vasant.hegde@amd.com>

On Tue, Aug 08, 2023 at 10:02:27AM +0000, Vasant Hegde wrote:
> From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> 
> To use the new helper function for setting up GCR3 table.
> 
> If system is booted with V2 page table then setup default GCR3 with
> domain GCR3 pointer. So that all devices in the domain uses same page
> table for translation. Also return page table setup status from
> do_attach() function.
> 
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> Co-developed-by: Vasant Hegde <vasant.hegde@amd.com>
> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
> ---
>  drivers/iommu/amd/iommu.c | 54 ++++++++++++++++++++++++++++++++++++---
>  1 file changed, 50 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> index cc42732820dd..4fed3fbe069e 100644
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c
> @@ -1821,15 +1821,41 @@ static void clear_dte_entry(struct amd_iommu *iommu, u16 devid)
>  	amd_iommu_apply_erratum_63(iommu, devid);
>  }
>  
> -static void do_attach(struct iommu_dev_data *dev_data,
> -		      struct protection_domain *domain)
> +/*
> + * Note: This is currently used when booting w/ amd_iommu=pgtbl_v2
> + */

I would drop all this commentary about amd_iommu=pgtbl_v2. That
command line option should be removed.

This is more about enabling the GCR3 when PASID is required.

> +static int default_gcr3_init(struct iommu_dev_data *dev_data)
> +{

I wouldn't call it default. On the ARM series we've been calling this
the 'kernel owned PASID table'. It simply IS the GCR3 table for this
struct device.

Jason
