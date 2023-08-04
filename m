Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95030AD37
	for <iommu@lists.linux.dev>; Fri,  4 Aug 2023 13:36:28 +0000 (UTC)
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-40648d758f1so14676211cf.0
        for <iommu@lists.linux.dev>; Fri, 04 Aug 2023 06:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1691156187; x=1691760987;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rFnF6bZuWMDLIU8svoV99BkmwMs8ORoSmrTuPpBjZW4=;
        b=Se7KxM16Ya9MCGJ0xgrHvi7Fx9+2HaUN9I9htFCAJoDgBV0PoJlDU0wI4y4I8kri+X
         bKIQG4HddIF/ekkeG+Rylw2SgigYJeHC03xHw7LNcg6r7CZTyozzNLVz0qq10sDippnx
         xT8Syr5l/4RXftJAP9A7ik0EYJvKWFEvYMRZ1Y57H/QCoILNzqjd26ftvFboxg6Uxwhr
         qAzAF8ckL/nWH6xklSDeo3ttcfOaJTslBLKWBM2zC77Ehli0A11ZYlF3jV7OH8YjuBK/
         BtOKrLsDq8cHfLR6cmcbqHYzCvuJiD3DuZMMGM2lKT+P1fqk4yOjbMksFZXv2rB42clK
         7c0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691156187; x=1691760987;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rFnF6bZuWMDLIU8svoV99BkmwMs8ORoSmrTuPpBjZW4=;
        b=TFPFaHuhezgOqk937uiT7jnhzvdOzsUup4H8pkdSsVKfT/A2pq/y6FCqfcTm4Y9D63
         uJKsh+foAX7qYdm/+S4KIkKTXR2ygzkweK6z4lYrfZO3IgH+beEojIWTJY37t7xmEuf/
         g5lvQqYhXL8+vTcXwCVX6wDQd4a4kB+YyC/AnnTcID5WFCk3rbxInH1Qo7v4CDgZ/VW9
         NSviNiwWsfERr1DRQfhlMZP1KsSHXXeN4anO3puUFkMs2j/+BmZbxABsLYQv0aZbtbKD
         3g5CEs+uO0iphN3loLFgokjPo1cnirLiUWnfcOLeQSL6RqJXU57Ko0IGIiTSiFUBL7h7
         L06Q==
X-Gm-Message-State: AOJu0Yx3b2Xf6Falm2uWyKLMTdLCIJoiau+NVQ4F8k5wdKfRYUYWlcnz
	f2h+mBW9MnNebbE7qhL/kk0khw==
X-Google-Smtp-Source: AGHT+IFgvMEj7g/0Qc2hcr8firbViKqtTX2C2Dk6ydVSqr/vvmMoSoAspJ0e4kxTXI7UrNZOP251pQ==
X-Received: by 2002:ac8:5f08:0:b0:405:50b8:dc1d with SMTP id x8-20020ac85f08000000b0040550b8dc1dmr2134691qta.48.1691156187266;
        Fri, 04 Aug 2023 06:36:27 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-25-194.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.25.194])
        by smtp.gmail.com with ESMTPSA id kc12-20020a05622a44cc00b0040ff1fabc7bsm657886qtb.36.2023.08.04.06.36.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Aug 2023 06:36:26 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1qRuyg-003j0a-6o;
	Fri, 04 Aug 2023 10:36:26 -0300
Date: Fri, 4 Aug 2023 10:36:26 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
	wei.huang2@amd.com, jsnitsel@redhat.com
Subject: Re: [PATCH v3 13/16] iommu/amd: Introduce iommu_dev_data.flags to
 track device capabilities
Message-ID: <ZMz+2kantGhQl47M@ziepe.ca>
References: <20230804064216.835544-1-vasant.hegde@amd.com>
 <20230804064216.835544-14-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230804064216.835544-14-vasant.hegde@amd.com>

On Fri, Aug 04, 2023 at 06:42:13AM +0000, Vasant Hegde wrote:
> Currently we use struct iommu_dev_data.iommu_v2 to keep track of the device
> ATS, PRI, and PASID capabilities. But these capabilities can be enabled
> independently (except PRI requires ATS support). Hence, replace
> the iommu_v2 variable with a flags variable, which keep track of the device
> capabilities.
> 
> Device PRI/PASID is shared between PF and any associated VFs (See commit
> 9bf49e36d718 ("PCI/ATS: Handle sharing of PF PRI Capability with
> all VFs")). Hence use pci_pri_supported() and pci_pasid_features()
> instead of pci_find_ext_capability() to check device PRI/PASID support.
> 
> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
> ---
>  drivers/iommu/amd/amd_iommu_types.h |  3 ++-
>  drivers/iommu/amd/iommu.c           | 39 +++++++++++++++--------------
>  2 files changed, 22 insertions(+), 20 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
