Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE94F6D17
	for <iommu@lists.linux.dev>; Wed,  2 Nov 2022 15:28:01 +0000 (UTC)
Received: by mail-pl1-f174.google.com with SMTP id c2so16888503plz.11
        for <iommu@lists.linux.dev>; Wed, 02 Nov 2022 08:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wP12hBLI/UjYflAvChPOlEUP0Fe9bcRv3GNq3jXeE+o=;
        b=oPg7EAxfhFVgkL5qNGfY4856C1CuYDrQT15DtL6CAfeFLX8YI4d839KNXQ4S+gqr3a
         jl0GyG/hjPYCfH8CFQOTECwjEjyDtxI5jMIWrIYga5TRq0kXfOXd9WDHC1Z//WkJKr9M
         Ad+DCW+vZTRC+nxDpNFkhVnFxaBoD0sK2hhdLLaaFhIVjXBbWRZtsm8j4QbOW5urUEsh
         QUwujKODHa/k883wtb2V2C6ovbNxfQKuOLJapf96fLqGvubzOHHsh3bsNDZTFiesw3Fj
         JKrcUe8+Fk9VgsGaOAMngyH68+2DM3jdLTjfELiAs3+3Jh7pfmiTrYtJePw+hvcxFtNv
         JbAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wP12hBLI/UjYflAvChPOlEUP0Fe9bcRv3GNq3jXeE+o=;
        b=NK6svR93Eonsa6j3RXF2nMerx6721RpHwaSp+N6c1OsDecxv5yWEtYXA0H2DTvuXTn
         M+UwdGXfoN3vqNDVd2MsH7G0Vs/7SHyeCY14VHMlBQcrXMhxr/HKkfUMt3yJi4pXeJbz
         bp7Hrx3jb8/3+NkwlKGkKfHIbi2fEP1EjapfiI6iQ/OOXrORm1aSClMU7pMn1nLa/JBi
         gN1WSa6L5blw504mv+1kCGfejjA7wynUANcycchGnq5UjfnKYvRo5wmdml4pSRROtcLv
         nvTueBeYqhrYfd2AJF8gUQxwArqpARq4kmY7OdrvMrUYBsHotdLaGI7INArlfbMVV0jR
         Smcw==
X-Gm-Message-State: ACrzQf08HehpJuX/hwGT9XRyqdpLRR3ztxP8AZ3Nh9Wa3LOGG+rJN4cu
	Zddv6IJuFXTgzG+4kpyQ5klLmZGqpJI54filgHIQ1Q==
X-Google-Smtp-Source: AMsMyM6A7lrylJay1xhevhaxJCaktaXQTaOKnMRfNs50tK6THAHyXvK0B1iPkGpZmNSeU8H+Mxp5/cQp8C9UHnx/UTU=
X-Received: by 2002:a17:902:b78b:b0:187:1623:827f with SMTP id
 e11-20020a170902b78b00b001871623827fmr18869518pls.165.1667402881129; Wed, 02
 Nov 2022 08:28:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAPDyKFpG9ZjVTiK3HEqioDN8ksGpRYiXL_SLSmOfm9fjJfcrsw@mail.gmail.com>
 <20221028130242.20900-1-pshete@nvidia.com>
In-Reply-To: <20221028130242.20900-1-pshete@nvidia.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 2 Nov 2022 16:27:24 +0100
Message-ID: <CAPDyKFqJdiCDkAfrONfnBVKw1v8=jZ+hEJiKGK70EQ4o7BSxaQ@mail.gmail.com>
Subject: Re: [PATCH v9 1/4] iommu: Add dummy dev_iommu_fwspec_get() helper
To: Prathamesh Shete <pshete@nvidia.com>
Cc: joro@8bytes.org, adrian.hunter@intel.com, thierry.reding@gmail.com, 
	jonathanh@nvidia.com, p.zabel@pengutronix.de, linux-mmc@vger.kernel.org, 
	linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, will@kernel.org, 
	iommu@lists.linux.dev, robin.murphy@arm.com, anrao@nvidia.com, 
	smangipudi@nvidia.com, kyarlagadda@nvidia.com, 
	Thierry Reding <treding@nvidia.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 28 Oct 2022 at 15:02, Prathamesh Shete <pshete@nvidia.com> wrote:
>
> This dummy implementation is useful to avoid a dependency on the
> IOMMU_API Kconfig symbol in drivers that can optionally use the IOMMU
> API.
>
> In order to fully use this, also move the struct iommu_fwspec definition
> out of the IOMMU_API protected region.
>
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

It seems like you claimed authorship of the patch [1], that was
authored by Thierry and updated the commit message header.

Can you please restore the patch to its original that was posted by Thierry?

Kind regards
Uffe

[1]
https://lore.kernel.org/linux-mmc/20221018105149.820062-1-thierry.reding@gmail.com/



> ---
>  include/linux/iommu.h | 39 +++++++++++++++++++--------------------
>  1 file changed, 19 insertions(+), 20 deletions(-)
>
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index ea30f00dc145..afa829bc4356 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -173,6 +173,25 @@ enum iommu_dev_features {
>
>  #define IOMMU_PASID_INVALID    (-1U)
>
> +/**
> + * struct iommu_fwspec - per-device IOMMU instance data
> + * @ops: ops for this device's IOMMU
> + * @iommu_fwnode: firmware handle for this device's IOMMU
> + * @flags: IOMMU_FWSPEC_* flags
> + * @num_ids: number of associated device IDs
> + * @ids: IDs which this device may present to the IOMMU
> + */
> +struct iommu_fwspec {
> +       const struct iommu_ops  *ops;
> +       struct fwnode_handle    *iommu_fwnode;
> +       u32                     flags;
> +       unsigned int            num_ids;
> +       u32                     ids[];
> +};
> +
> +/* ATS is supported */
> +#define IOMMU_FWSPEC_PCI_RC_ATS                        (1 << 0)
> +
>  #ifdef CONFIG_IOMMU_API
>
>  /**
> @@ -600,25 +619,6 @@ extern struct iommu_group *generic_device_group(struct device *dev);
>  /* FSL-MC device grouping function */
>  struct iommu_group *fsl_mc_device_group(struct device *dev);
>
> -/**
> - * struct iommu_fwspec - per-device IOMMU instance data
> - * @ops: ops for this device's IOMMU
> - * @iommu_fwnode: firmware handle for this device's IOMMU
> - * @flags: IOMMU_FWSPEC_* flags
> - * @num_ids: number of associated device IDs
> - * @ids: IDs which this device may present to the IOMMU
> - */
> -struct iommu_fwspec {
> -       const struct iommu_ops  *ops;
> -       struct fwnode_handle    *iommu_fwnode;
> -       u32                     flags;
> -       unsigned int            num_ids;
> -       u32                     ids[];
> -};
> -
> -/* ATS is supported */
> -#define IOMMU_FWSPEC_PCI_RC_ATS                        (1 << 0)
> -
>  /**
>   * struct iommu_sva - handle to a device-mm bond
>   */
> @@ -682,7 +682,6 @@ bool iommu_group_dma_owner_claimed(struct iommu_group *group);
>
>  struct iommu_ops {};
>  struct iommu_group {};
> -struct iommu_fwspec {};
>  struct iommu_device {};
>  struct iommu_fault_param {};
>  struct iommu_iotlb_gather {};
> --
> 2.17.1
>
