Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D07B2C952
	for <iommu@lists.linux.dev>; Tue, 21 Mar 2023 14:41:21 +0000 (UTC)
Received: by mail-qt1-f175.google.com with SMTP id bz27so6326740qtb.1
        for <iommu@lists.linux.dev>; Tue, 21 Mar 2023 07:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1679409680;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VsESyQmPEYPtlv8Qtns7l7XM+vfyI6Pmh9fN7mCM7RU=;
        b=eHkykCav8PIbZ8d6K8QZ6Rtx/B23qF8ynIK5Inpjk3UWanV0GOlFzWYcLMy6vRtM+l
         dMp2FPdu5yNaVh+Xptj4CfUzs9jy8R/G/Tig8W8hLneo9HND9GxtWbJxTs0w9R+q5a1J
         M0nMrReffPok/IOndWtu2Mi2tXtDrLdFYQPnsGG1wuZThYsOBDWOyHUaftXhSUD8eVYp
         qhE0Pi7kIllt1i54g7KqTwHOLXRUFc1QQeKKPlPX0M73AykshOs2HNKN304sxRgWcT5h
         BN3ElDhcRr+KmU9GgMdfFQKvzNyBNjHYpmFePFEj2dGTgx37Lb9rPwb8CJhwiYsswybM
         ugNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679409680;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VsESyQmPEYPtlv8Qtns7l7XM+vfyI6Pmh9fN7mCM7RU=;
        b=WScIpqopUqa+kFTB1rFx29eITcfYRHukMsH4PahGFkj/mKVbywaOYZT6az2XHk0OWQ
         zShBx/EB8Y2pc5xTwyGJzk15MDulj7fQdFVYfWRv6Ugt3Qeot5GuBJG+8p5EB8EwmzRb
         gzJHVyYULX7Jcm7mH9KKIf70I+wxeuEcWi8k0vm8WHvBZLrH7GBoelnqsBXfkMTJ2aCR
         /Z0wY2hUvjKtGb5rJ5RjlzVxUhUpDMq5SE8pxd/gNKPe7+g46oU/8mnW+CAMaNUA59gg
         InMvazPR22r3OR1d2dU8khyLlXSNNb3vtVhF/U8HxMperO1HOxso7Q3Ieku44su003Y3
         2dzQ==
X-Gm-Message-State: AO0yUKW9TAVaDFPWuDZCb8EDIJDxwWATvgYMt2wcPAtf/ln8ZcRMOAB+
	YL5/mQqqAeZe8KmJsgiGt0xMvQ==
X-Google-Smtp-Source: AK7set+UzRDTVZ0qoylhnByM6ScHpCtlilLXdrBM9ohzsnMm3+w0gXwuni40utMRZ9ry2o6G/Ho9cw==
X-Received: by 2002:a05:622a:2cc:b0:3bc:dd23:cbb2 with SMTP id a12-20020a05622a02cc00b003bcdd23cbb2mr5322002qtx.33.1679409680729;
        Tue, 21 Mar 2023 07:41:20 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-25-194.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.25.194])
        by smtp.gmail.com with ESMTPSA id jr28-20020a05622a801c00b003bd0f0b26b0sm8257944qtb.77.2023.03.21.07.41.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 07:41:20 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1pedAt-000VZN-Nm;
	Tue, 21 Mar 2023 11:41:19 -0300
Date: Tue, 21 Mar 2023 11:41:19 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: iommu@lists.linux.dev, linux-samsung-soc@vger.kernel.org,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v2] iommu/exynos: Fix set_platform_dma_ops() callback
Message-ID: <ZBnCD7Xc9WCM55ub@ziepe.ca>
References: <CGME20230315232523eucas1p2565ef5954e3b5b451803c6200c8bce32@eucas1p2.samsung.com>
 <20230315232514.1046589-1-m.szyprowski@samsung.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230315232514.1046589-1-m.szyprowski@samsung.com>

On Thu, Mar 16, 2023 at 12:25:14AM +0100, Marek Szyprowski wrote:
> There are some subtle differences between release_device() and
> set_platform_dma_ops() callbacks, so separate those two callbacks. Device
> links should be removed only in release_device(), because they were
> created in probe_device() on purpose and they are needed for proper
> Exynos IOMMU driver operation. While fixing this, remove the conditional
> code as it is not really needed.
> 
> Reported-by: Jason Gunthorpe <jgg@ziepe.ca>
> Fixes: 189d496b48b1 ("iommu/exynos: Add missing set_platform_dma_ops callback")
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
> v2:
> - keep set_platform_dma_ops only on ARM 32bit
> 
> Some more background why set_platform_dma_ops is needed on ARM 32bit is
> available here:
> https://lore.kernel.org/all/9a12fcac-c347-5d81-acef-1124c50d0c37@arm.com/
> ---
>  drivers/iommu/exynos-iommu.c | 17 ++++++++++-------
>  1 file changed, 10 insertions(+), 7 deletions(-)

It seems OK, but do you know what state the device is left in after
exynos_iommu_detach_device ? Ie is it blocking or identity?

Jason
