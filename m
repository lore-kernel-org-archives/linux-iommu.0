Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D94A522F09
	for <iommu@lists.linux.dev>; Thu, 10 Aug 2023 18:33:57 +0000 (UTC)
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-447c22f326aso503558137.2
        for <iommu@lists.linux.dev>; Thu, 10 Aug 2023 11:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1691692436; x=1692297236;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iS/Prf0uZRyER4yw6CK3K10VBvAKS1eThkp8nNBAT68=;
        b=evGcRu2+HFFc2q2yBwYT9DIUAlzZW+04mOxnRs9oVvmlPKMpjtg/akgaGFTNGRCezC
         owS2PQrvYXD+j13HL4urjHZ7ZJ4+C2k42UBCaI2UPqzwrvpPonW8atuasa3oSK3hbi8j
         u9RK1G8Rex5ZMehuNcbXcxtDnAqzqNUXHloN5u/XdOGTZ0v8DL6vdpRB62CAx88hboYW
         txx0gUDWWOI73nAQKbrhFlB/kdSUsqSGQzTcvT5tBW0yxfks0Fjd4RKeHjbzgw/RNX0Y
         wsrZInZZ2Ot5wCzJ56OuaTqTAgZsWGUyQ0yGsfXVgN1PrEMbwz64IjD88ovrOi0UJffQ
         C8Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691692436; x=1692297236;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iS/Prf0uZRyER4yw6CK3K10VBvAKS1eThkp8nNBAT68=;
        b=J/j+UYm3CJnnRpZif2mCfeesNBBVSjgziCjDLqjKXsW+Oqhnqp0tmzBhHRsBbCK9vW
         hfxfIGu2WDBysQMTYjFAO3ATVGgRAym9wCL5UC5xW1MtAMfJ4nn7oDZLSLqkn2HYuEA3
         AWQwfaUPZhfesf1C66aMkOS8Zo3pZMufILwgA27ZTfJrBTt+ydaMXfzvDGMXnZAxCH5j
         K59qHBki22apg+i7yUK58x9+jkAkHHc7zn6wV1oIDPCfKf5t4VoY+ENApz29wyZyxLX2
         c/ucdXXcC9HZZuwZobWQehFT5dk3QoAt1GBqHMOYeotY65I2vsRZ1LU+d5WC1EAjLKaX
         rePw==
X-Gm-Message-State: AOJu0YxEKCL4djEtYryvIG6Yv+WhwL0rCnF648rjTaoUTSYl6DHWImFS
	dcTG02IvHdI4inEjukSOcmSRbg==
X-Google-Smtp-Source: AGHT+IFs5Jon13TN7iGbJbDF1FdmsGHcDUJAFFT9T2ikHmRv3TZExjSqIKY5whXUkeFcw4V6VqgS/w==
X-Received: by 2002:a67:db95:0:b0:447:4520:43b1 with SMTP id f21-20020a67db95000000b00447452043b1mr2680208vsk.7.1691692436396;
        Thu, 10 Aug 2023 11:33:56 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id p14-20020a0ccb8e000000b0063d245c00b5sm669270qvk.0.2023.08.10.11.33.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 11:33:54 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1qUATq-005IHE-95;
	Thu, 10 Aug 2023 15:33:54 -0300
Date: Thu, 10 Aug 2023 15:33:54 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>, iommu@lists.linux.dev,
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 04/12] iommu: Replace device fault handler with
 iommu_queue_iopf()
Message-ID: <ZNUtkjRhi5c/W8pD@ziepe.ca>
References: <20230727054837.147050-1-baolu.lu@linux.intel.com>
 <20230727054837.147050-5-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230727054837.147050-5-baolu.lu@linux.intel.com>

On Thu, Jul 27, 2023 at 01:48:29PM +0800, Lu Baolu wrote:
> The individual iommu drivers report iommu faults by calling
> iommu_report_device_fault(), where a pre-registered device fault handler
> is called to route the fault to another fault handler installed on the
> corresponding iommu domain.
> 
> The pre-registered device fault handler is static and won't be dynamic
> as the fault handler is eventually per iommu domain. Replace calling
> device fault handler with iommu_queue_iopf().
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/iommu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 4352a149a935..00309f66153b 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -1381,7 +1381,7 @@ int iommu_report_device_fault(struct device *dev, struct iommu_fault_event *evt)
>  		mutex_unlock(&fparam->lock);
>  	}
>  
> -	ret = fparam->handler(&evt->fault, fparam->data);
> +	ret = iommu_queue_iopf(&evt->fault, dev);

Also fix the function signature at this point:

int iommu_queue_iopf(struct iommu_fault *fault, void *cookie)

It should not be 'void *cookie' anymore, it is just 'struct device *dev'

Jason
