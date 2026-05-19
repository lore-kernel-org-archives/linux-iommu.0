Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25EA735201A
	for <iommu@lists.linux.dev>; Tue, 19 May 2026 14:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779201471; cv=none; b=bIK7xD3HCllYuJBuEdlBpVvgvvc7fTWUMrNHpKASVnXX58+WRweunW66dO7kMazH0ScXXtQ6huxnIzACWb6tVQspPTtnguRtzjuF3SuEeaJmwH8Ez8a3DmACFdg4zcCdSXHaXYFbCh2WfWsJd9FNdp8bzbPO8X00PiAr5elL3b0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779201471; c=relaxed/simple;
	bh=xoUre0ZHh111UbHEIDXHq8nedRN8EZ+gBdSl0fms4oE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CTUWlF4bOhm8Ra9pP91hZQZAUNrR3s+vKRvkO3jU/QWpoeSSx7Hq1Fl4Rkfp9pzRJuNcpPDElNQ06MzpUx6kC4ADUsyG1eB/iBZIvZXIfvJrDvhYbY3BRI/3ff262o956i+TSsRNJ8/gm8HX+ZTVQS43iCK2eYtlWxWvZDo83/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=TidShZgg; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="TidShZgg"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-514ae601df2so16128071cf.0
        for <iommu@lists.linux.dev>; Tue, 19 May 2026 07:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1779201469; x=1779806269; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xoUre0ZHh111UbHEIDXHq8nedRN8EZ+gBdSl0fms4oE=;
        b=TidShZggqvjdep96YVbug7jBreMZhZg/O2tvcpDLFfKA+QrchDze2h/7EQYg1UUPEn
         Ryet4vnzIxC3mjsJc8JxUYwbsQ/xZTwL4wqtmLMY1AYAFq0KoxUQ4du6YhUWIf2Owug8
         IuyxGnY2/4IHWsolT9wsvoRAPTbqNL0yuQKgexu+TAx2cfjx6gU0KRBdZzdBniUOUcls
         svGqynswU2ThL384sUrSauavKl1fxf8v+0ye+lqDtyHbqz9uBG6AqD2lADks3JvB+usH
         riqBKaTRhOgJTs7JCz2L72/ITzimo0YqzXDnnagq+Fu4ewNnp+oRqLP8u1Eh9Uul9Yyz
         oynQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779201469; x=1779806269;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xoUre0ZHh111UbHEIDXHq8nedRN8EZ+gBdSl0fms4oE=;
        b=Cks1Zlqo+Gxv8SNDY0mMx+pLA0isQRBPBNL6nWZh4VSYLHXiaoRuJ5Nz5jajx1Drer
         OXoZJDz5qd3E2bLSXJgo+Ll2omtYEIiRkVCoepFPXpe7LLG4UAvc32+W+67iBiP0HrO3
         FvwZTs9bscIbN7rY8T+q4pI+xuFM5hADCF2VqtdDElcC/sM8BIIxSe1KsjstSc1sERkc
         F7rOGWxjq3tiTR7PQyhIiq8t3psp2Ip1DF2KoIhS1kea8XIwgK49WIm6P8LcEx8kX0GO
         ROk6jiQWHJYstFzhcQD2xYHRf3vkI1WaEjyUqKlPOwmmKR0quTBMQlHHNy7lerPFe/bi
         cloA==
X-Forwarded-Encrypted: i=1; AFNElJ/biRXiloFkolnZnzFLVFk0Ut6ycqG9wsyP7AWOu9Auho/tHFR/0T7SOT2Xa4i+D25gNRJFtw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz2WezdZ2IE6xwDsz8b6821lTZAhxoTEx/DoXlJBwRdHnPewGBb
	KjF6INKXUskdv0jRmbJmNdxU1jnggRNMeZ+nJ3DJfd42HKEUmVC9AlyAEfE0HvA4BJ8=
X-Gm-Gg: Acq92OFIOoFf0oxXPqbovJPTpPOAzu3DTXjmKjx5vJQHROamcF/7hImCiMpchc6nr5u
	mhvbNs0MC44dndWLxTxUiEaNc0qhQE5L41XnYjCxTQ1zuxiM9rooZ2Szs39hXAOn2g4ULTqb/iZ
	fxo+s2bvhuhCVJCqdaHGQHWfKEf6S42uVsHbUEgW/lMtRDu8puAuOC8DDAzIl7AxidAE4yK+Qte
	icRO3jiMH7ZCE2sWzXB/R3qNKitCCTEZbTg4+sozWLKN/2p3YdhkwqGjIlokW+wZpbJtGcksm9S
	c+Sr33Fw0vcG5Jbf2OWbZFrdDDWbhYwsFh9LVmKwoIOuiz/VyKmgQpUFbnXmFeD3g5fds60XmS+
	Y19moJTYEuxcJB7zzZAJbgdvfmG3WN68g/Fm6WneTiLK4Kq0A50Cxf/bKEYfFywQOJBDLh4T00n
	+vWeP7l72VKes7K0vBf49XxhXdrB/pYtTRlnUUImcEoTZPn4zTM3PaxsBSiaWTUc9lNGvk8WWpf
	Ouvg/+t9X8NlQ8E
X-Received: by 2002:ac8:584d:0:b0:50f:c26d:f31f with SMTP id d75a77b69052e-5165a046334mr283700431cf.19.1779201468969;
        Tue, 19 May 2026 07:37:48 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-516456b6856sm165713481cf.7.2026.05.19.07.37.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 07:37:48 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wPLZr-0000000F80e-38LO;
	Tue, 19 May 2026 11:37:47 -0300
Date: Tue, 19 May 2026 11:37:47 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Mostafa Saleh <smostafa@google.com>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-coco@lists.linux.dev, Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Jiri Pirko <jiri@resnulli.us>, Petr Tesarik <ptesarik@suse.com>,
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
	Sven Schnelle <svens@linux.ibm.com>, x86@kernel.org
Subject: Re: [PATCH v4 04/13] dma: swiotlb: track pool encryption state and
 honor DMA_ATTR_CC_SHARED
Message-ID: <20260519143747.GE7702@ziepe.ca>
References: <yq5apl2y5f96.fsf@kernel.org>
 <agXaby-7L7yS3Vva@google.com>
 <yq5ah5oa59wy.fsf@kernel.org>
 <agxDxdxynp4KEovA@google.com>
 <20260519132911.GA7702@ziepe.ca>
 <agxolksC_1nfO34X@google.com>
 <yq5ah5o3sdn3.fsf@kernel.org>
 <agxt7SFGT7OLMIah@google.com>
 <yq5aecj7sctv.fsf@kernel.org>
 <agxzanDBmIP54hUz@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <agxzanDBmIP54hUz@google.com>

On Tue, May 19, 2026 at 02:27:54PM +0000, Mostafa Saleh wrote:
> However, as I mentioned to Jason, I think with some tweaks to
> force_dma_unencrypted() we can make it work under pKVM for aligned
> memory which eliminates some of the bouncing.
> I am currently investigating that.

force_dma_unencrypted() literally means that memory passed into the
DMA API *without* DMA_ATTR_CC_SHARED cannot be DMA'd from.

It should not mean anything else. The DMA API should never decrypt
passed in memory. You always have to bounce.

Jason
