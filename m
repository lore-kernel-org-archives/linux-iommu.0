Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D44CC6FDF
	for <iommu@lists.linux.dev>; Mon, 21 Aug 2023 13:36:42 +0000 (UTC)
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-64a8826dde2so19697896d6.1
        for <iommu@lists.linux.dev>; Mon, 21 Aug 2023 06:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1692625001; x=1693229801;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FDY56LX20XWtO5aIYmJVebUwmR4LKKiq4VQM/rHOBB4=;
        b=ooS4RhJ0I5Ylu44zZY127XD1LQes/9L4pWD1hJfwLNp700n+0EoM1p+u0XTI0wGEPy
         /i967/4BDMkfpjwrIe/6/RIHBNRqQaV190Ut/4JyJQINBPWESsGDPH8lXe+2EeV/x7Jq
         cwgVUNBrbRV7l7NvD95OKm7jdau80Axs7SsS+DKRIW8GRkcho+uYbm7PUvQquuvH9Txt
         e36YTsFuXYp62f0AUG+nqjr5x/jfIDiK4LurM0aLdkoQnqFwAs4nlHhyB/UGSswxxJf2
         Fs/HEZ906z2aSubifaFrsts0CHsU9Ke7ud9NOuEBU8S4Z/wGf92dxTGQKz0a2FgspIr8
         kUng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692625001; x=1693229801;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FDY56LX20XWtO5aIYmJVebUwmR4LKKiq4VQM/rHOBB4=;
        b=lKJOVI+yNZkgevGlAQY2a8ANhHp596SqjaMVzgffKBT0hr40mlDr0E1c5W7mf2x5XF
         X4PsN+EysMz+dsGaGzRYMiGOx3Mb1f+0K/jDb23+cetv+9jgldhZZ+y1Cn5BNrq05Pwd
         5QMbONwol0Up8EZJt2WfhuZjlLaPuDUNX4x85YWpOg31QEDQysHefczXcfpNxE+NRlBt
         4crSux+5rzjb5SGu5/1qkMPB/on4hAtwlc/azWYmmaOTlx5Ng1lITHwOUNNL0i9vd/vj
         01/8bXYl8Exnk5Y+WIH+fiOC7RtsQSyhvjgWzuvDHY88ldzS+mc0WyiMWmDQhf0GFMLP
         YaKQ==
X-Gm-Message-State: AOJu0Yy/AgyaopBkN6l51ax3lKyYadh0BZS9PPI+mR69+jp9n7yirirj
	PtbvAlXcOJdfAMRCU7S8a5tfpWQONZ1ChX/gUf8=
X-Google-Smtp-Source: AGHT+IE2bG+1LwWqVsS+WCEV0UytMLi2ydkILUQeNiCi6YG1sasYmfos+twjlsNpbDVqpVXCU/ncHA==
X-Received: by 2002:a0c:f106:0:b0:64a:3ab9:266f with SMTP id i6-20020a0cf106000000b0064a3ab9266fmr7340455qvl.49.1692625001559;
        Mon, 21 Aug 2023 06:36:41 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-25-194.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.25.194])
        by smtp.gmail.com with ESMTPSA id g6-20020a0cdf06000000b0064718983683sm308495qvl.117.2023.08.21.06.36.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Aug 2023 06:36:41 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1qY55E-00DiI3-I1;
	Mon, 21 Aug 2023 10:36:40 -0300
Date: Mon, 21 Aug 2023 10:36:40 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
	wei.huang2@amd.com, jsnitsel@redhat.com
Subject: Re: [PATCH v2 0/5] iommu/amd: SVA Support (part 2) - deprecate
 iommu_v2 module
Message-ID: <ZONoaEJpCuKPQ5Mn@ziepe.ca>
References: <20230821104956.707235-1-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230821104956.707235-1-vasant.hegde@amd.com>

On Mon, Aug 21, 2023 at 10:49:51AM +0000, Vasant Hegde wrote:
> This is part 2 of the 4-part series to introduce Share Virtual Address
> (SVA) support. This series removes iommu_v2 module support.
> 
> AMD GPU driver which was the only in-kernel user of iommu_v2 module is
> removing dependency on iommu_v2 module [1].
> 
> [1] https://patchwork.freedesktop.org/series/122124/
> 
> Also subsequent series will add SVA spuport in AMD IOMMU driver. Device
> drivers are expected to use common SVA framework to enable device
> PASID/PRI features.
> 
> Hence this series removes iommu_v2 module and the functions used to support
> iommu_v2 modue. Note that there are certain functions (ex: PPR interrupt
> handling code) which will be used in subsequent series for SVA support.
> Hence not removed those functions.
> 
> This patch series is based on top of SVA Part 1 [1] :
>   https://lore.kernel.org/linux-iommu/20230821104227.706997-1-vasant.hegde@amd.com/T/#t
> 
>   Also to build kernel with this series either we need above AMD GPU
>   related changes [1] -OR- compile with kernel config 'CONFIG_HSA_AMD=n'.
> 
> This is also available at github :
>   https://github.com/AMDESE/linux/tree/iommu_sva_part2_v2_iommu_v2_v6.5_rc1
> 
> Thanks Jason for reviewing previous versions and providing feedbacks.
> 
> 
> Changes from v1 -> v2:
>   - Added patch to revert commit 2380f1e8195e
> 
> v1 : https://lore.kernel.org/linux-iommu/20230815103255.565295-1-vasant.hegde@amd.com/
> 
> 
> Thank you,
> Vasant / Suravee
> 
> Vasant Hegde (5):
>   iommu/amd: Remove iommu_v2 module
>   iommu/amd: Remove PPR support
>   iommu/amd: Remove amd_iommu_device_info()
>   iommu/amd: Remove unused EXPORT_SYMBOLS
>   Revert "iommu: Fix false ownership failure on AMD systems with PASID activated"

For the series

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
