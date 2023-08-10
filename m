Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 932CF1E1DA
	for <iommu@lists.linux.dev>; Thu, 10 Aug 2023 18:20:10 +0000 (UTC)
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-40ff796e8ddso7921831cf.2
        for <iommu@lists.linux.dev>; Thu, 10 Aug 2023 11:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1691691609; x=1692296409;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AXmx+3wOCZyKtOJ9UV8BupnM6hUAbNraEzN8cHZ1GF4=;
        b=E1ARSMdxCkr4+jcHFhO8dLLVCyuveqJnD1w4IRmhOVHRAt89TlOie5lu4GnI/SDppL
         eypA8Fb0zr9/R3D9nLVm26wl8Ms2xoZxj8hbX9HsaoRnL7D7ivQZyyzb2IgoV60yTa1I
         SmH+wJpfY8XS0GAF9H6BSjD4fn++6WcNcTNhKru1rrAI5BhB3VsHZ1BZjTHeGm/RLbxN
         K4c9Y/asghJG7cSWo9KiSMhvQ7b0SJkF7FVt9bWpZwZGx4/hi/dUg7konG4QNbRhfXx7
         tFQZ3KEa5Aiv/0xcK3vBBymfrPSwVqOQ6yGzvaQ8BaAotL9niirPiN8pjWuP3GsT/q3g
         OqZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691691609; x=1692296409;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AXmx+3wOCZyKtOJ9UV8BupnM6hUAbNraEzN8cHZ1GF4=;
        b=ioT5PnE+SjHK+h0cDh/vG3+g8VvxAA1UFThwi4UBVKsVJk5hPGTao8IFUEHBBEWs3j
         VdKckXYMSj54pHXP2Hdna/9GdnclRMqFOXiaAqHAY7e9kaYxckipOM8nszhCLNcdLlwt
         pO9+RbsX0eQRE1WNcdAl4DaSuHtPWd2N3vR4zKw2gZAMLg8NsZQxcaa4Umga4xrkojv9
         vFwpKjnTnezFVoPpFlCR/VmCbBJ1wDNOEzFcT1rda/iIjruCnv2qVWD4CgonACqZgOU5
         kiDOtyGO+1D2I6rFEyODh8jr2VMIbmwaWA7qeDcY20nwdxgF1XpSFAcEcT62MYfTcKZq
         X2fA==
X-Gm-Message-State: AOJu0YwTsvpEJ9vBSIcGq8+iTzU5Bc9MY6+3gCP6a4bkZG5Vr9o1OnOr
	saF279rUhoRAd8PbJTkmRYoBiiynZbgfrR7OQw0=
X-Google-Smtp-Source: AGHT+IGM/hUoXEwYhGIeNdIi+ksUWiqdR7FvNX1iIrgGhPeHR+9PMnIfVbvj2S3TUzJyh2+51QHwww==
X-Received: by 2002:a0c:cc0e:0:b0:63d:a05:256a with SMTP id r14-20020a0ccc0e000000b0063d0a05256amr2792632qvk.8.1691691609165;
        Thu, 10 Aug 2023 11:20:09 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id i5-20020a05620a074500b00767f00a9c67sm658732qki.95.2023.08.10.11.20.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 11:20:07 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1qUAGV-005Hsi-57;
	Thu, 10 Aug 2023 15:20:07 -0300
Date: Thu, 10 Aug 2023 15:20:07 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>, iommu@lists.linux.dev,
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 06/12] iommu: Make dev->fault_param static
Message-ID: <ZNUqV5Mte2AsVa1L@ziepe.ca>
References: <20230727054837.147050-1-baolu.lu@linux.intel.com>
 <20230727054837.147050-7-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230727054837.147050-7-baolu.lu@linux.intel.com>

On Thu, Jul 27, 2023 at 01:48:31PM +0800, Lu Baolu wrote:
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 4ba3bb692993..3e4ff984aa85 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -302,7 +302,15 @@ static int dev_iommu_get(struct device *dev)
>  		return -ENOMEM;
>  
>  	mutex_init(&param->lock);
> +	param->fault_param = kzalloc(sizeof(*param->fault_param), GFP_KERNEL);
> +	if (!param->fault_param) {
> +		kfree(param);
> +		return -ENOMEM;
> +	}
> +	mutex_init(&param->fault_param->lock);
> +	INIT_LIST_HEAD(&param->fault_param->faults);
>  	dev->iommu = param;

This allocation seems pointless?

If we always allocate the fault param then just don't make it a
pointer in the first place.

The appeal of allocation would be to save a few bytes in the common
case that the driver doesn't support faulting.

Which means the driver needs to make some call to enable faulting for
a device. In this case I'd continue to lazy free on release like this
patch does.

Jason
