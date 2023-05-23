Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19DD34C7B
	for <iommu@lists.linux.dev>; Tue, 23 May 2023 14:47:33 +0000 (UTC)
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-30950eecc1eso5235729f8f.0
        for <iommu@lists.linux.dev>; Tue, 23 May 2023 07:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684853251; x=1687445251;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zPxJfv8Gp/np80rJQlBAE1bGG9in5p+Ub2ud9nocz6U=;
        b=WqoXIxmjF4fRAuTza7LWI2l7Be8/QIYJutSNRRaw6QSkA0mZSS80UAZtniMf9EPffx
         OJ3DQ4IWYyAQdL5dtehn8ytxLkeS218smegrauZjfoDvgLIPqyaA471Ff6rz4yYDo8L0
         eihGyFOEA4EXqQwzbTXi1GHtWmaD/2gTaCX3tWaEvNU5utjQSjMCCEtIvD8VlLNV7rXl
         MvBWX/tUboGmcWG7a2buIakdgPUPd5FnKQXFBgZuDHTyU4/lFGLUcEWI8auxq4+QU1Ty
         xgJsnP06DonVPnXiEblbtQ9eMi5u1EOqtmVRt7KpKabtmIFukFHkC8e0ct4b3138yvOQ
         DHiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684853251; x=1687445251;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zPxJfv8Gp/np80rJQlBAE1bGG9in5p+Ub2ud9nocz6U=;
        b=VsPVUBz6u3W1jevYND0lpz1HawB33ovXefQhIJNHP+cjd3RrgRMhB+a4RhNQSs1/yy
         BQNLsg/YxH7AciclQ8G60rVRQKS5TP0vH6xnl8FElDeTnASPpUfZPX1aQmyWHxhtjbm1
         zE/Bx0IiBsKVzFsdXbeWt8wT7VSDjU9SR2OVq3gB0oMBxv8F2kk7AGHdEEiuhqdA75f3
         12LkDQIUlxXdTvpJFTdjVrF5nWq5xro0cGpS7rgrMN428ldX77FgjYhi5GWBD0jXCaYw
         m7wakmmUHPLP6TNbUmKLQ4f6BVDmxQfXlXP2fu0GoCuP9JMnc0MCGZqoL4SGGySTR7dn
         obow==
X-Gm-Message-State: AC+VfDysKiTrF0+JaYzWHqZXlabb40RskBNcHs3aNLZeRYaR617BAf8b
	XROrrMxTHKxDbLl5TAi7yC5t3Q==
X-Google-Smtp-Source: ACHHUZ4qBBoaISjw1qz9BvpZKAg8+GG76ZYbL0DJwXL+ImXaMvFn5rvjbJsBDtXwIQLEzMgaoe0Plg==
X-Received: by 2002:adf:ee82:0:b0:306:2aa7:2ecc with SMTP id b2-20020adfee82000000b003062aa72eccmr10390763wro.45.1684853251337;
        Tue, 23 May 2023 07:47:31 -0700 (PDT)
Received: from myrica (5750a5b3.skybroadband.com. [87.80.165.179])
        by smtp.gmail.com with ESMTPSA id 10-20020a05600c024a00b003f423dfc686sm10151223wmj.45.2023.05.23.07.47.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 07:47:30 -0700 (PDT)
Date: Tue, 23 May 2023 15:47:33 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux.dev,
	Jason Gunthorpe <jgg@nvidia.com>,
	Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
	dmaengine@vger.kernel.org, vkoul@kernel.org,
	Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>,
	David Woodhouse <dwmw2@infradead.org>,
	Raj Ashok <ashok.raj@intel.com>,
	"Tian, Kevin" <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
	"Yu, Fenghua" <fenghua.yu@intel.com>,
	Dave Jiang <dave.jiang@intel.com>, Tony Luck <tony.luck@intel.com>,
	"Zanussi, Tom" <tom.zanussi@intel.com>,
	narayan.ranganathan@intel.com
Subject: Re: [PATCH v6 1/4] iommu: Generalize default PCIe requester ID PASID
Message-ID: <20230523144733.GA4137946@myrica>
References: <20230519203223.2777255-1-jacob.jun.pan@linux.intel.com>
 <20230519203223.2777255-2-jacob.jun.pan@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230519203223.2777255-2-jacob.jun.pan@linux.intel.com>

Hi Jacob,

On Fri, May 19, 2023 at 01:32:20PM -0700, Jacob Pan wrote:
> PCIe Process address space ID (PASID) is used to tag DMA traffic, it
> provides finer grained isolation than requester ID (RID).
> 
> For each RID, 0 is as a special PASID for the legacy DMA (without
> PASID), thus RID_PASID. This is universal across all architectures,
> therefore warranted to be declared in the common header.
> Noting that VT-d could support none-zero RID_PASID, but currently not
> used.
> 
> By having a common RID_PASID, we can avoid conflicts between different
> use cases in the generic code. e.g. SVA and DMA API with PASIDs.
> 
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> ---
> v6:
>    - let SMMU code use the common RID_PASID macro
> ---
>  .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   |  2 +-
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 10 ++++----
>  drivers/iommu/intel/iommu.c                   | 24 +++++++++----------
>  drivers/iommu/intel/pasid.c                   |  2 +-
>  drivers/iommu/intel/pasid.h                   |  1 -
>  include/linux/iommu.h                         |  1 +
>  6 files changed, 20 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
> index a5a63b1c947e..160b31e6239d 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
> @@ -80,7 +80,7 @@ arm_smmu_share_asid(struct mm_struct *mm, u16 asid)
>  	 * be some overlap between use of both ASIDs, until we invalidate the
>  	 * TLB.
>  	 */
> -	arm_smmu_write_ctx_desc(smmu_domain, 0, cd);
> +	arm_smmu_write_ctx_desc(smmu_domain, IOMMU_DEF_RID_PASID, cd);

I agree with reserving 0 globally for non-PASID DMA, but could we call
this something more generic, like IOMMU_NO_PASID?  The term "RID_PASID" is
specific to VT-d and "RID" to PCI, so it looks confusing here (this driver
also supports non-PCI). "NO_PASID" would be clearer to someone just trying
to follow this driver code.

Thanks,
Jean

