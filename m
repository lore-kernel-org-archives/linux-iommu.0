Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA84C355F49
	for <iommu@lists.linux.dev>; Mon, 13 Jul 2026 19:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783971446; cv=none; b=VA+ZFffVWc/AAzZo1e2EYmlbX8QiIpkn4EicwMYtu6DYPOcbzTAFbsjH5ezSusO4wKYLWHJY6enLWkGGCfPhJB5VMKSiUeaN8XFAmmkK48bplZXK8E0qLbKcKNRVobLS1UsKGx1cw+lvgrx1FL/m8ztzmZuVyFN5LpZpZ5Lwheg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783971446; c=relaxed/simple;
	bh=Xsfi+SO6SJr84aSbkQrUqh5LTCvlYWMyrm0+dQckaBI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QHfH1F53ztGHofrN3Yj/A1cWY46dntH+hm9P8y8nNa7KcQASKNRO93aagFj4AqQ4hd2eEU5XTLheRyYmJm35MZN4yS9xxTWu4j2lgNopINaIWQpwkuosqc0sSgbDDtGBDGPHAsUk0ua9bi52yxUWymDr+cT07YC2wuYnAJpb71E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=HLzx9YJ9; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="HLzx9YJ9"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-92e5d50b0dbso16344885a.1
        for <iommu@lists.linux.dev>; Mon, 13 Jul 2026 12:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1783971444; x=1784576244; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=seRQ4x7WCVBDlRNvM1ESoBfWnXSVwL4ZPJ5Cc52Vq54=;
        b=HLzx9YJ98+aYxH2RmkFDCgbSs/3EcqOM4IkLZbDdE4BTSpWj1vWpaJsoQyrLya+356
         NNilWDH1eL66NKeeC0n2XqXRoZshJ/s3PNx6QUssvyzXLXiQUX3h0AUxF+c3+gH3GRy8
         MLovZHNSSZBmn8zCPOoSN4ASZ8AXb7pHX4nWIjZ290PL9YeWMjnOKec5Omru/Sde4tfd
         5f7bnDHZ8fMHlCWWn45ULIM1n50w+wBPwKQByesMJEY0kyZvDBsx5SITKFjI35APMBXO
         68xiSThhyE2HpuPvSHAMxZpliRdFdr3doiedudH4NN71CFFhhrRuTpzrTnWTr4xvH/O2
         +URQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783971444; x=1784576244;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=seRQ4x7WCVBDlRNvM1ESoBfWnXSVwL4ZPJ5Cc52Vq54=;
        b=LXm0FIlLHASv+6B/BaMhUSCEBh/Lu2MqsKtDAuPcjmRhaF/sjdUS9Vd4vnA0/m/rWl
         B66SpfPDA2srM9vYMTOXlf5wewUx+h6CHYSHbr1VOeY1uIVTeB9W8f5qr6D5OO2BeTOO
         GRg5FN/Yx5H9I7LdmKB7pSGLIoKKOyn4vdwLIL8AVsEAJSMRGmY8i1qlCwZKqMZRtHB5
         ImuJxzZEc6lUh36hJFHd1fK8ggLUKjar1my2RbkqqMBQm4ba1KkPQNhZa//YNrvqUAv/
         07+IJzYHrMIEdHU8NmEqN6+l8J3jN0R1nrwjdFIZaHO06JyFFAtW5eZ/rziu6fuVUO9f
         Nn6Q==
X-Gm-Message-State: AOJu0YzAYMPvc8cRnQKqvuBpcG/1sNcllZtcwfjB40iTgOf0OPfUjXk8
	ksf2rIJ6UnsxcH55zGaW3jLeBlFE0a4bnOwVZY/gJcTtGWQbU5416nCm0EfX4/Y6f+A=
X-Gm-Gg: AfdE7cnRnwAQF2w5fHoySEe3wWe7voxwXMB6ad6o8VviErOPI5vL4TuzXo1tOXtGs4s
	8cGaMn1gXNwiGV4kqTKZ7iCt5Q99Wj4ARpWsO6a6SiyFyIXbMV0s5t1HNntXi2WTrZIpHlRUtHe
	ZHs4uDPsgSNRueGnkhs1CfeCUKOleg1e3ckqo+EQq0h1Qs0vlJ+Oh8dKJMFqcB58LtRTmvZmgel
	wXF6PP730+3lWEHU4kTN4DueGxCgUwLzXcK1NYiO9TEmejRU8R2vVxVYSRgV3mti8WLNYPKu7Ac
	DVMp1ca30ON9cQw8/VS37HSV0vBhfPsX9ZhdDuNdatxdH+Z4f8OyoPTR1Wo55Fz2eL91LhnIUO0
	J6RisSof1DWF2O7jK8tFXTQHzJZaYfYuizEZIzirmRcKn+Iky1u2rWrgUHXzAVv9ehRzHkjo=
X-Received: by 2002:a05:620a:2551:b0:915:5930:94e6 with SMTP id af79cd13be357-92ef2bcc91emr1112783085a.51.1783971443832;
        Mon, 13 Jul 2026 12:37:23 -0700 (PDT)
Received: from ziepe.ca ([159.2.72.92])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92ee5b86276sm1177578085a.11.2026.07.13.12.37.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 12:37:23 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wjMSw-0000000E6Rs-2gqS;
	Mon, 13 Jul 2026 16:37:22 -0300
Date: Mon, 13 Jul 2026 16:37:22 -0300
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
Subject: Re: [PATCH v7 17/22] dma-direct: set decrypted flag for remapped DMA
 allocations
Message-ID: <20260713193722.GW3133966@ziepe.ca>
References: <20260701054926.825925-1-aneesh.kumar@kernel.org>
 <20260701054926.825925-18-aneesh.kumar@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260701054926.825925-18-aneesh.kumar@kernel.org>

On Wed, Jul 01, 2026 at 11:19:21AM +0530, Aneesh Kumar K.V (Arm) wrote:
> Devices that are DMA non-coherent and require a remap were skipping
> dma_set_decrypted(), leaving DMA buffers encrypted even when the device
> requires unencrypted access. Move the call after the if (remap) branch
> so that both the direct and remapped allocation paths correctly mark the
> allocation as decrypted (or fail cleanly) before use.
> 
> Fix dma_direct_alloc() and dma_direct_free() to apply set_memory_*() to the
> linear-map alias of the backing pages instead of the remapped CPU address.
> Also disallow highmem pages for __DMA_ATTR_ALLOC_CC_SHARED, because highmem
> buffers do not provide a usable linear-map address.
> 
> Tested-by: Jiri Pirko <jiri@nvidia.com>
> Tested-by: Michael Kelley <mhklinux@outlook.com>
> Tested-by: Mostafa Saleh <smostafa@google.com>
> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
> ---
>  kernel/dma/direct.c | 56 +++++++++++++++++++++++++++++++++++----------
>  1 file changed, 44 insertions(+), 12 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
