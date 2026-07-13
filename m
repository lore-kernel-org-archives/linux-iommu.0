Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA5A8357D0C
	for <iommu@lists.linux.dev>; Mon, 13 Jul 2026 19:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783971695; cv=none; b=pBm63RVCTww9uWqO5p+Tng9vuBPakMvvcEfFkTxbNKb85zCD2lk9y0zBlD3xaeVKHUPAuYTtFE3Y88i/WfpSMPVcaEB7cjrVlWWBz5B+7cjm7LWRpYM72v3RKnsweLT6TQcDVPuoTv+Zo100qgtNogSWos51QkItelL0jgXCxZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783971695; c=relaxed/simple;
	bh=B2Rb2Qu3H6K9h4z3M1wOOTBejPY5tvykheBX1AXjDsU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b8iHL1xFfay0CT79sMOrSxfG5ECYZqizJwmvTN32nmmFiTCKoxYSI/8ej+iI9LAwNHFJCQ3eOTowT6Rib+EsF3R5lgx58vOri1gtNHgX1N00bcmGAoVHvHfUN9em4a2Mn8XisLP97qL54PD+nUo1DRbO5buMiL1jGYJiQsdbj9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=G5NRlAy8; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="G5NRlAy8"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-51bfad59921so27651411cf.0
        for <iommu@lists.linux.dev>; Mon, 13 Jul 2026 12:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1783971693; x=1784576493; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=RaFiCRG6TDd5hbIwyaOKkhGT65gZ81YsG2fbaxJfaHI=;
        b=G5NRlAy8cwkrAh1Prkq1cAg4bZzK2z+kGBiu3BuO5Fftb9jRU+CKhuPSrF3SxcWsCm
         iqrmqWSBLMbNVuaQPvGrWH4jzn6TqSTnRuBszK3NtJuDZo3eMpXm9E2CGw4FPooGXBb8
         t8HoIjPvNYVHEblCtxBRvVY0EG/+WJgwQHT0LVjbeJ+kyjSgHbYQxT2oDkTkJQWk2Xoo
         Yd0Zbp4yQkc3+rxcgGTGVPKe2cXrl6Hpvo3/MQZgq8fBNg428N1PcWBM6O/BdXyOcLQM
         kJN1ddYAwQebc8WAHmzAJL+DJwQKHEWFn8NXNEsZCz8mBlJcQb6i4Bklj2PtMZbEdJoP
         x0xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783971693; x=1784576493;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RaFiCRG6TDd5hbIwyaOKkhGT65gZ81YsG2fbaxJfaHI=;
        b=jpXEvvWlplKze+CCjSh+5IIVvAM4q7W46Fn9QC5VDiMSWNxZujF/LNBCMmfGKBDFgm
         49VwGdsEiJ3ZT+UNjn+remCSPcg3RsGwSVxPTbonR7DfuHoANA/W+M1RBVFlXjS0SQRa
         r4LdIS5/dSZTw7AU10s2LPSyg7C32ZOCpJhP20mGd//7TGx+3UjMPtAPZy5z8deffG0i
         NhD1qhtfghr4MG+oiZigWsRqYZUUAaoOc5l5sO4A9vDQmsAwznmYA4TALTCCnruozohN
         +WTZ/vH4KJ+MY6S8Zs9nIrwG6zK7ybboJ7VjTO1anoNLT9Mt8HFIZix9eta2P98GjmDf
         0HIQ==
X-Gm-Message-State: AOJu0YzEsQnS5ZJvKC5KIpiherZ9MBxQjxJnyyd4shd/YxmIhr31YuQe
	bNH0E2nUP0PcjSozw0GyNEMQIqZbnsaakpzm5y8sV1G0GnCewukeHJbblXTv7pQF79s=
X-Gm-Gg: AfdE7cm6pzz9jHmpkhI4LoEyUY3CU9agUd+BX+X2iRzON8Z6fxUS5lliIVgMBZaBD7X
	xoq7I3Rtp2ngKdn10RuKY9cnvb7pXFTU/QUiPlACZzetPQTSIz0uPxEk7+liIRn/2xjr/2GQjYe
	kyvpKegmAyeHA2IeR0ON+DQ2KmMqO7dfhfEwTejE/PRTYHrptQNFQZ9Luql8OkC4LmAAJguOwSA
	MXqeMF7wmi+ITmuIpKp6RHvYb7js9YDBFLa46baO+0X1vD2T7qKdmn7njV4pO2qIRQLszSOsBWf
	BOy+B351yUijLLnPtS250HR6KuR4uHog3Z8QUfdSTjo+QWfTeUs2KdwQos+ftk7/qsn6u2oXwXY
	IiSDwQ6zyHbvUGAjMgDzgoEn6+4Uhi63Akm/9/0AjXgI+lO4nrpDDWTl5h7Qb
X-Received: by 2002:ac8:5fcf:0:b0:517:8711:d46c with SMTP id d75a77b69052e-51cbf0f3fa9mr100726891cf.31.1783971692761;
        Mon, 13 Jul 2026 12:41:32 -0700 (PDT)
Received: from ziepe.ca ([159.2.72.92])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51caafd8b44sm90213801cf.30.2026.07.13.12.41.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 12:41:32 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wjMWx-0000000E6nC-2kaU;
	Mon, 13 Jul 2026 16:41:31 -0300
Date: Mon, 13 Jul 2026 16:41:31 -0300
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
	Michael Kelley <mhklinux@outlook.com>
Subject: Re: [PATCH v7 20/22] dma: swiotlb: free dynamic pools from process
 context
Message-ID: <20260713194131.GZ3133966@ziepe.ca>
References: <20260701054926.825925-1-aneesh.kumar@kernel.org>
 <20260701054926.825925-21-aneesh.kumar@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260701054926.825925-21-aneesh.kumar@kernel.org>

On Wed, Jul 01, 2026 at 11:19:24AM +0530, Aneesh Kumar K.V (Arm) wrote:

> @@ -840,7 +843,7 @@ static void swiotlb_del_pool(struct device *dev, struct io_tlb_pool *pool)
>  	list_del_rcu(&pool->node);
>  	spin_unlock_irqrestore(&dev->dma_io_tlb_lock, flags);
>  
> -	call_rcu(&pool->rcu, swiotlb_dyn_free);
> +	swiotlb_schedule_dyn_free(pool);

This knows if the pool has cc_shared memory in it since there is now a
flag tracking that? So should the work queue version be conditional on
that flag?

Jason
