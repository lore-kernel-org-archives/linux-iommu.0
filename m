Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98F6F437103
	for <iommu@lists.linux.dev>; Mon, 13 Jul 2026 13:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783951002; cv=none; b=H/H/1bm/gWSBQ+waQINJjIQQkM0RSgBQYON8+poHmb0Ge0iXLM/4qyqdCWcQ8mgkCRQdngzFB4JJQgWF9q6h8LEC7cec8Ki01hah41ey4dNlxKOCvyP8IeqoV/mZTH8tTagivMe2fhRJ8cbO3UiGmAQRXz9nscR4XyLMjpFeO5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783951002; c=relaxed/simple;
	bh=9KihY4IsvKVp0Oht8qbc03FAQfSZWEfFvdyOwhTMNR0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eTywzvqRs7RNj6Mm25nMLAw2xqazAX1V9NT9Vm64Qvc3VLwNBbfzT74Ws96S+YviiK3HdICwRFW2+xbWknSIL0rf6SNKB9vZ7shUSFURZNSccGqd0S4E+lSRa9iwbXy3xsp9EJIKpGplXgUSgEByItz/R2rPok/adS35SJcfOR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Lt1FmMTx; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Lt1FmMTx"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-8fcc43c48f7so27401526d6.2
        for <iommu@lists.linux.dev>; Mon, 13 Jul 2026 06:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1783950999; x=1784555799; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dThHBkWDs48b/2hz2YL35z2V9VnPq+MKY/40ZoZ5a/U=;
        b=Lt1FmMTxCj0Ky7eqeYGiGLxRtVuQ57iLNAOD5ATO2+L7kTjk4Ivn0IqZtT7yOJsyKj
         /hQMEpmzM3QxVuzxyYYb8Nc3435/H5lvBEi/HL7t3hZ84D5+TKjGmAZI9W/qTUholUp0
         MQZNTLNw9xDlCF1+gAgBQ5/LWzJK9KWSLBzp7Wj+FLHNZv8QGIbFUTPzPIeXCtJFnmXl
         xBwKNcpYdFjjdLSjgFPYv4UL6HndULlFvmQ57hqvFB3pkUEJGgRJuyfMn6AdOrBbiody
         vtE7r3qVVjCmb2iz4cm13DjcMFDsz/pGxgxKWbkXaHvlcWpw4srMovzMuYWElU6MxJhu
         0lpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783950999; x=1784555799;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dThHBkWDs48b/2hz2YL35z2V9VnPq+MKY/40ZoZ5a/U=;
        b=Nk8AhqfpHYFIahWaZ5jJpR9It03sxV7yDaB3nqX+abxbajXZJJj4IRYfGmvBCnVsqe
         /QWV7cgavIz+4lV9tDubK6SxtIPk9WK+y4ykd2iNKFE1u4inBWhEJgYFwWMKBZWziWZH
         Fh/KyRLyWz0vdwATPpSe1DrSq8K57NR+p7yCNQl/5hp59EBXVBRaZofr7kv2r3iSg4Qd
         qSnUzoMJzXBxZNG+F+pEgv2iSXXRae0IwhVwediCjSHSczBd0jaj6mb/SW09/dRsjS/A
         2vl79bFgkogVduToE0gDJB0a1nABJvpZA4gMsb67dyBdgEouBkV22lpt83Pr7XeHJI7Q
         i1bA==
X-Forwarded-Encrypted: i=1; AHgh+Rr9yHjeQQoSPSM4CKzQ/10L/wcjf/3NrLhtMEEaTwqdW42oeYvg7yhXKbhgUlwYTVwrfpPWtg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyGi0tbKHONsvH5fuNHCv0nG9HvQEyjl2FRixQy9BfKOy3y3fK1
	bTdDQ+O/E0QsJJq1yBaoOOA0ikAmJd49kifUDNOF/rbnPPCTlxWLUpnxmYvily6J9cW0Av38CmD
	q6Ibr
X-Gm-Gg: AfdE7clP0nHOcDdtcswLzSDHBMyAC27ZxS8kEaRs5pM4BE8TqHm+EKcWv3Vwq2r47DC
	WvA8xQtfJApfLU1mzloTyqrrox9rP1YUJrrgR7SNd3QzNHUf2IfZPIMKYdjqTV0Kky0gWiHbMoY
	K4s/otbKZ5GZvEOuz953R1j+GBZboHcEj5MJAi5bcVQFyEaWSywhiG1dkgjqLddFTBqlYjMqI/Q
	YNE3mcIv2kBXwlE4uvIBSOBBZupU+FRagcj2+pIWqK71L0dX7oU57FCOhsHDoValRQyqanPap8i
	kujCkNOsbRjxxZ+FbfI+wDIOz8mw7RAjN1I3pG61Rt04+JpaRZgX8yC1LpoLUkrcHwm+a99ZJgj
	oZqHYmyRT5fXOwbEi6PLD2cPrvV9FikRBnuEsmJEu+jWjlaXCJm98Kh5wGZAk
X-Received: by 2002:a05:6214:da9:b0:8ee:756a:f1d3 with SMTP id 6a1803df08f44-903ffc638e5mr98221496d6.28.1783950999687;
        Mon, 13 Jul 2026 06:56:39 -0700 (PDT)
Received: from ziepe.ca ([159.2.72.92])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ffd81f4bbdsm126704796d6.36.2026.07.13.06.56.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 06:56:39 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wjH9C-0000000DL9o-26N7;
	Mon, 13 Jul 2026 10:56:38 -0300
Date: Mon, 13 Jul 2026 10:56:38 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-coco@lists.linux.dev, Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
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
Subject: Re: [PATCH v7 16/22] dma-direct: make dma_direct_map_phys() honor
 DMA_ATTR_CC_SHARED
Message-ID: <20260713135638.GB3133966@ziepe.ca>
References: <20260701054926.825925-1-aneesh.kumar@kernel.org>
 <20260701054926.825925-17-aneesh.kumar@kernel.org>
 <ak42F240d-53QeFN@arm.com>
 <yq5apl0xgy89.fsf@kernel.org>
 <ak-CT3oanlDfgTy4@arm.com>
 <20260709181336.GM118978@ziepe.ca>
 <yq5ajyr3h106.fsf@kernel.org>
 <20260710161945.GO118978@ziepe.ca>
 <yq5atsq6hdaa.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq5atsq6hdaa.fsf@kernel.org>

On Sat, Jul 11, 2026 at 12:39:49AM +0530, Aneesh Kumar K.V wrote:

> > But if you really want to it should be
> > cc_platform_has(CC_ATTR_HOST_MEM_ENCRYPT) *only* and get rid of the wrong
> > force_dma_unencrypted().
> >
> 
> Ok, I will update the changes to so we preserve the previous behaviour
> for SME?
> 
> 	if (attrs & DMA_ATTR_MMIO) {
> 		/*
> 		 * For host memory encryption treat MMIO memory as shared
> 		 */
> 		if (cc_platform_has(CC_ATTR_HOST_MEM_ENCRYPT))
> 			attrs |= DMA_ATTR_CC_SHARED;
> 	}

I'm OK with this, with the expectation we should aim to remove it when
fixing the callers.

> > But IMHO, I'd rather this series treat ATTR_MMIO as private MMIO and
> > ATTR_MMIO|CC_SHARED as shared MMIO and that's the right and correct
> > thing for the DMA API.
> >
> 
> If you think the rest of the series is ready for upstream, could you
> please ack it so it can be picked up for the next merge window? I'll
> repost v8, rebased on top of the pKVM topic branch.

Yeah

Jason
