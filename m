Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C02C3451C1
	for <iommu@lists.linux.dev>; Mon, 13 Jul 2026 19:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783970522; cv=none; b=LK+iyUBHbi44byey2TEAYCaNobAbEFUCuyUysXdM3Fk/P6qc0JdEZpz6oV6uX4KzP69W9MDisyXSGjdN0aqBmNhdJqAQ2weLoWy2U4nc4HLnKrNaPrc39u8EJXhulIFCuHEddR+nq9Cy9ok56qvUAUuudBcXTFbmm10cTVWhJfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783970522; c=relaxed/simple;
	bh=2S23cLlbDaDZPWx0WS3KxZy0gp3jtCk2pWDFCTO6yTU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SvzvW5Sbnnj82bUxEnJxepcYSpsKaQ8862ttv30tmFH6bbQe9biRnb5bNzMoaI75y2ukj4eyH9Ol92FXN1TZZMNLDi+y1eDTQuuNTxBL7NM99dLnl9sXcNWWfrXn31cS6Qm/AiU6dC8z50h3cXBI2EgdmW/zXiHWHTin8lWzPtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=VOJFOU7a; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="VOJFOU7a"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-92e55b62640so204982885a.0
        for <iommu@lists.linux.dev>; Mon, 13 Jul 2026 12:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1783970519; x=1784575319; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Kt1NNWVp5vzCd+THxZiV4tdGJLfhiT0ZXPz0TueqWMw=;
        b=VOJFOU7aLZ6tDRUeOALotmNj4PbOc9hbulAL96iFnuoIRntsmbEE8Rd30N2dpZJRTr
         +zDgY/DTmuWpTpF9PIy+SCTauBK0d6C69uc/N3M3bsvqDu8dDoF5A9qnwpwuobGdBiTi
         +LyOZ7fuq4QSf5U6dJ7cQNxpLbRGAVOYayaQmbq+iFY/XBoziVjOXKtc8Wh+HCClAlUf
         2woHRIAyB9jXk7keHOKIC5LPdQssY1reR0+y5KWWE4Yns5io42PhPoh23iGwgh/kAuzy
         +qWESQh9Wm2RCSi9mocEBgroD4oKOEp9rwF+s54PLBSo30nD7Sw+LSluNA5F6xBMlqkt
         NQZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783970519; x=1784575319;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Kt1NNWVp5vzCd+THxZiV4tdGJLfhiT0ZXPz0TueqWMw=;
        b=KzgX2qVTXMaeGdwXv0qEcOYm3GB9BEl/jxIzMWss1tii9HrbGzF3Y5/zxQdX/A0Zz4
         Azh1EcqcBcZIOvRIGKnZjBUfBcC4TEyaRB8zm68/iPxvK77gkQbXsP9sZ7ig+6FM/tLi
         mzfoQmGSo/s7RYlpUYc8gA0Jdj3DzzeWHzZ7bMccTlgvPCW5zNKYpfMAzP0SK3VzE7DA
         oG6/HC1zDT66+pssGewkMvn4wcaQzdoAOqR7/oblepiUZnPdGTEhN02G0szw0hwiDUp6
         5RpFGMfeqxfmvUqtBRTmtWrdVYWncD3MkxuSb6mNpFXkvX+qxvbq1q26wQkRBOuGtloJ
         niNQ==
X-Gm-Message-State: AOJu0YxMUWe8XknWNsi7Rp5rqHgOB6DlQ7Vs+pKfrjtPLoJIa4Rw1c7z
	wfNRapzH1+nxvTigK5FLc2Egq7PUFXSSXDgsVHwKq8coq0uXB3qhTbfkF2OLsUepTUs=
X-Gm-Gg: AfdE7clkfrt9r+Zgv/VOK/Q3tpnBStN+SrUeI8x55JSUFQOgtlOIfpy7HuQvIZTGrC1
	RVMHV475YuqpRgUDlnkJfnqySxt5RsX2nTxZ4PHJ5Hu9aLQ6xE1wJxFwiOIwm6jsOXS/Bu7GmTC
	jCIGNEoNNBeQjD8Rxm3EYya/TvGu8rnl/dxyszv6pg2JRpraMhkn0hXwpi1j9HWRPbQlIe/bMqW
	8+qI6xNrDY6KLwG62XT8lG1H6CsUrEfyDQ09wZ7+2+yGwrGnAW+DBBlujNaOGrm7v9jM359z/6O
	v8xgfHxNwKuwvD8yNXiU29AhFdQamrg6qJ0lXbFHyjdxFY+7+6rDjlQmxm/lpiwqx06t3iagBpV
	qy97YWD/oYY7hPfvT3ZurJTp0YYBBo+pzaDVqZtzM3jXKnM1ug+2TrntAkX6KqgVQ7FpNPzo=
X-Received: by 2002:a05:620a:44cf:b0:92b:6805:eae0 with SMTP id af79cd13be357-92ef2c0c787mr987778485a.61.1783970519182;
        Mon, 13 Jul 2026 12:21:59 -0700 (PDT)
Received: from ziepe.ca ([159.2.72.92])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92ee5cf7ab2sm1122922585a.30.2026.07.13.12.21.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 12:21:58 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wjME1-0000000E53O-3cBb;
	Mon, 13 Jul 2026 16:21:57 -0300
Date: Mon, 13 Jul 2026 16:21:57 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev,
	Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Jiri Pirko <jiri@resnulli.us>, Mostafa Saleh <smostafa@google.com>,
	Petr Tesarik <ptesarik@suse.com>,
	Alexey Kardashevskiy <aik@amd.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Xu Yilun <yilun.xu@linux.intel.com>, linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>, x86@kernel.org,
	Jiri Pirko <jiri@nvidia.com>, Michael Kelley <mhklinux@outlook.com>
Subject: Re: [PATCH v7 10/22] dma-direct: use __DMA_ATTR_ALLOC_CC_SHARED in
 alloc/free paths
Message-ID: <20260713192157.GQ3133966@ziepe.ca>
References: <20260701054926.825925-1-aneesh.kumar@kernel.org>
 <20260701054926.825925-11-aneesh.kumar@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260701054926.825925-11-aneesh.kumar@kernel.org>

On Wed, Jul 01, 2026 at 11:19:14AM +0530, Aneesh Kumar K.V (Arm) wrote:
> Propagate force_dma_unencrypted() into __DMA_ATTR_ALLOC_CC_SHARED in the
> dma-direct allocation path and use the attribute to drive the related
> decisions.
> 
> This updates dma_direct_alloc(), dma_direct_free(), and
> dma_direct_alloc_pages() to fold the forced unencrypted case into attrs.
> 
> Tested-by: Jiri Pirko <jiri@nvidia.com>
> Tested-by: Michael Kelley <mhklinux@outlook.com>
> Tested-by: Mostafa Saleh <smostafa@google.com>
> Reviewed-by: Petr Tesarik <ptesarik@suse.com>
> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
> ---
>  kernel/dma/direct.c  | 42 +++++++++++++++++++++++++++++++++---------
>  kernel/dma/mapping.c |  9 +++++++++
>  2 files changed, 42 insertions(+), 9 deletions(-)
> 
> diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
> index 0cbf2b0835c4..98e47e0b332d 100644
> --- a/kernel/dma/direct.c
> +++ b/kernel/dma/direct.c
> @@ -192,16 +192,22 @@ void *dma_direct_alloc(struct device *dev, size_t size,
>  		dma_addr_t *dma_handle, gfp_t gfp, unsigned long attrs)
>  {
>  	bool remap = false, set_uncached = false;
> -	bool mark_mem_decrypt = true;
> +	bool mark_mem_decrypt = false;
>  	struct page *page;
>  	void *ret;
>  
> +	if (force_dma_unencrypted(dev))
> +		attrs |= __DMA_ATTR_ALLOC_CC_SHARED;

After going through what was left of force_dma_unencrypted() once the
series was fully applied you might consider something like

  dma_update_attrs(dev, &attrs);

To remove the frequently duplicated code

It is fine like this too

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
