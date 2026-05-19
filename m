Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABA9740963B
	for <iommu@lists.linux.dev>; Tue, 19 May 2026 13:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779197355; cv=none; b=h5fGgvzhbPO5SvBauRikuevLyfGlWqrfvelWbNtuxbPpEuJkRMPlhh/a9gFBt6znl+sAXuhC+lmsL6MVsS0Uik5qDS/hl0yHXR3EIxQGno4MAV80pm1/TDRc10q8VEEOvTGoY8Cbd3eOMNwmxzthyvGZfiZPCAJImMWIyAKguQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779197355; c=relaxed/simple;
	bh=dbxAh3jWVdvQ1+R108C1f7Lp/JMDaW8ElH0OVbL5tww=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qx4WVPnjpEg7jcsUPdtQMFD8k2Gu/jRTRcAb1QKZfZMX/aDoz4hUTAPb1Wpyxh7WZpTBrdZp/6LE7iriHEcvIGFQ3CXJnKNJKVq0Z5MIA+o/cRHDI6YrxFt5OddqpqCulUGIXwOPMhxqvGtEgmdfRrhPlHvyEO1d34TU2VFRALo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=SFzzMERM; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="SFzzMERM"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-8acb856a674so48209746d6.0
        for <iommu@lists.linux.dev>; Tue, 19 May 2026 06:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1779197353; x=1779802153; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LrtAP8Eaa/f2vd8w85VzyR8xqf5rOlnG9+YArbfK2NQ=;
        b=SFzzMERM3mkjP1aLWtGSysWk9HYRb2IH8eS+B+m27pSiqj9tqQ8B2iUuZP7PBZquFy
         jdve4QlTlEnN8S48yqgyyRkrzNFR2rzKbdTb7/SmaPQyoPcKg+mFiiso6cHn2enrcANz
         y4LtpH0gLActH6id519ZCCqvM9q6nO3zCAdu4LUDVQ8zev8pY8pjCGv5qaXx3ozicVFL
         8oAmKADcYK9Js1GPgtIfAPUpGSci3NLA9IdErKKBjqLqvKGoCJjTLi7QSF3TZTrPBMN1
         gjEWBvVv9fZdHGo/LAVNuWbvP8rIegp6jfOBaZL4J0Cz9T8ufhiXdiqhphTMuGm9pCk0
         XPtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779197353; x=1779802153;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LrtAP8Eaa/f2vd8w85VzyR8xqf5rOlnG9+YArbfK2NQ=;
        b=OJ0Vy2MAC8aO5oMGxu3xrQDs254x1UCUV5aOTjQWtOH+RvlftzkqB9Nclshj1JmNEa
         l7CZHccYxvsrl0EfN1tCIB1ALPZtDSKYAIJuqbkDgBCjX/N0i6aTxhw5eDgbDqbWJDJp
         fW1vVzbyLeE50Y4EPlQJOVHgIqePBvQ/iWBMVorDERdd92JhXK2BN/Q7BQ8rPFMY5ne4
         qaa7j7IyxZme8+5fafnHhKkqZ19rJzxhwsKPpXbini4/OJB68DuOw/n0iVO7ifSpEv+/
         pDE7gmF/1MMWmz+IAFOcxM5L3p0VqGDSQ5IKuoOkwKl9QcyeoQO8Z5ajnfze6BIBFmGv
         sGkA==
X-Forwarded-Encrypted: i=1; AFNElJ9qqbXMfkAE+hzv7wmTjCfCl1xm7hKG5fbxg7jdc+7ZREPXvxbI7d/XHi6VAEtQRXRqxCcNUw==@lists.linux.dev
X-Gm-Message-State: AOJu0YznnXcYOpR9VQvhfCt/Q7I/3YrynGboDuRDJwIz0i0SmaSm7IPY
	XJdJ6hhiVo8qJFk/yNO/P5xm/JGenvJ7t5tRs/yeMdPaiThltulepdrQseYln/NnAtE=
X-Gm-Gg: Acq92OFbQPChOEzqJv2NeQ0/yRsStTL3oHGZWfodHIcRkoPxnhEVk78NF8REsaEetQC
	o+aPU+CZPuLf6xNgGIS3rjPbG6hXhJC3arIW1p66hpzyeyBJSTFVw6I5R3KYKzHkhkmtYpQfgEj
	A06eWuCb8h3HalXx2tU9YzsRy7P9AC/s+RiaYf6zWd4QDPPHCbZ2jFetKRKwsw6MxVsWRGVhned
	GlQ8qfqkdlFYAK3kjeeajlKf9mD5bS+xTeUoXmabmOGlhk1q6wTMA+xbZEbmQ12RymhdCWa98K7
	iBrUdmsE+eSFU1VBhTENLCkeuX3mBzJxG8E/yJxi88n5L9aU6cSHPPEgSo3C+326uT/lV713APD
	+1ZPi2bhGFGEqIf3EQhv0rr+1jEVzFYfyQkIMHAzCIKNQhch1Lv6RBLDiQWPFf6SZ0YTYKLAWRK
	LjCFZ0eMJrR/C+N7ZRgz8RDrHAYiZX3kx7reLFByHOkBv8V1D79BwZDgelfz+a1BP4oo+aRAl2m
	pdOO2v0AonRp0dv
X-Received: by 2002:ad4:5ca9:0:b0:8c2:7cc5:b5d5 with SMTP id 6a1803df08f44-8c8fda1ccb0mr344078466d6.17.1779197352561;
        Tue, 19 May 2026 06:29:12 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ca360979c2sm90678436d6.18.2026.05.19.06.29.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 06:29:12 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wPKVT-0000000EubB-2Vp2;
	Tue, 19 May 2026 10:29:11 -0300
Date: Tue, 19 May 2026 10:29:11 -0300
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
Message-ID: <20260519132911.GA7702@ziepe.ca>
References: <20260512090408.794195-1-aneesh.kumar@kernel.org>
 <20260512090408.794195-5-aneesh.kumar@kernel.org>
 <agSKQrSIhizCXKwx@google.com>
 <yq5ah5oaa63h.fsf@kernel.org>
 <agW5rhE9n2gDQ0w5@google.com>
 <yq5apl2y5f96.fsf@kernel.org>
 <agXaby-7L7yS3Vva@google.com>
 <yq5ah5oa59wy.fsf@kernel.org>
 <agxDxdxynp4KEovA@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <agxDxdxynp4KEovA@google.com>

On Tue, May 19, 2026 at 11:04:37AM +0000, Mostafa Saleh wrote:
> On Thu, May 14, 2026 at 08:13:25PM +0530, Aneesh Kumar K.V wrote:
> > >> 
> > >> What I meant was that we need a generic way to identify a pKVM guest, so
> > >> that we can use it in the conditional above.
> > >
> > > I have this patch, with that I can boot with your series unmodified,
> > > but I will need to do more testing.
> > >
> > 
> > Thanks, I can add this to the series once you complete the required testing.
> > 
> 
> I am still running more tests, but looking more into it. Setting
> force_dma_unencrypted() to true for pKVM guests is wrong, as the
> guest shouldn’t try to decrypt arbitrary memory as it can include
> sensitive information (for example in case of virtio sub-page
> allocation) and should strictly rely on the restricted-dma-pool
> for that.

??

Where does force_dma_unencrypted() cause arbitary memory passed into
the DMA API to be decrypted? That should never happen???

Jason
