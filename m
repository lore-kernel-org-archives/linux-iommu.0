Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D60F9445ACC
	for <iommu@lists.linux.dev>; Wed, 29 Jul 2026 10:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785319696; cv=none; b=PzkL7lcbXiBEG1LO4r8uG5IX8JsBh572c8frJP9VZx5N0U61l9ZHjcNTlbQct7FqAUjtfKU+7a/MvXnS5BsF4ray1leV90sPpOh4VSH9635gCGEldknBPZt348N0O2GnDyOizIFO00ZwymHYh2zdVe+Bkq7+T8QRayz33Qa45PE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785319696; c=relaxed/simple;
	bh=lGLVQcsztY5awYnmlsVk+k+eu0JF7WHu3B8vPUeejOw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cvMHtnNci0SgXSdblre+meT9IhIhAiTD412fgrygclkjy4QQuSCKIdBHLIgqlR16sn4w4opZ9SPXVznjn53hIBrwGk/6vqiAUqm2iFkOtAR6B2yFopRu+c16R9/nXl/+csjXbG+zkR9d/Xu75oMYXaDwqlJRml/boz+6o9gRO4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XtxzcWce; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XtxzcWce"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-69fec8b4638so10917a12.0
        for <iommu@lists.linux.dev>; Wed, 29 Jul 2026 03:08:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785319693; x=1785924493; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=y+s7LRa+xfn1TaMGIJNFktf1+ZXT37mg0JkHIAIfYYQ=;
        b=XtxzcWceRX642naNz3jlLBJ2MVK3itV7Wwze3CMaTmLb/dxlzFuDO1KKKWREi2V+RO
         nXSvEUAx7tR7Yxj9HeA4Ip9eYZNmgrVM+tZcS8RQiw6I9MZoi19Mm/K2xmbJ5XgvYPqi
         h0mRj0AqhVWHeCDXD099VGPnRuWnXCfUxskzKK0Gr8G1CeS74P1gaANIEV8WN4ibkp2v
         xy4cZ9Ycxesk7OUeG2HREHMT9hclOcz2VK3NP3l/2hXNXLLvRr4SIfq3HblcS7JA+xZh
         G9Pk+C4fNNKcx7NZVW5OybhNjVVPMUhSGvqKBfhoi59+19GV/LuhVdTuRZTBeKdGa6Qu
         qY+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785319693; x=1785924493;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=y+s7LRa+xfn1TaMGIJNFktf1+ZXT37mg0JkHIAIfYYQ=;
        b=MfgI4KWRDeL3S0CDUqKv4pBLQ3xasJtiy/18osSF2ogDIvMcXTp1UqjSD0qn8Oic1e
         x0iS2yYmGtwtqqo7s9iGOZ5fAenLerzdXmL0fbI7L2YIwqJDBHVSvwK08d4Nqw0Rpl1Q
         kCr4FWoL01KrWEpL8HkANcHmhZ4zdrdp6ZKM/VO2pTAigOA54VTi034YMrBaiRwF9X2Q
         auL//c6vajucJItd5y15CVMRQpqIwVTLQTl9xhAckqwlRkhY+uUmer4NXoIg/u0fWidI
         PsM6+WYEOg2fbIPDhKnIx6syZRpiL7Tob22s+wYEc0tNd0Sdkm8F0Vn0i/n6Y17BL9Lg
         LMTg==
X-Gm-Message-State: AOJu0YxyF5NEwsajRg7prJNFJ/xZJ7mh4xPYawd2Vr8C5i3kv6MkdT7p
	Uypsp+oXqmPXGOl1j1h09TM0u49PhDbZzHf9y+nfkk3NaAls5ZQjpOzkDv5j/NDv5w==
X-Gm-Gg: AR+sD10AiwRaARsR+VJAtK/zbIXAfnJt6eoTZT9nuqB4VblgOGi70rSCRiPSu5HLt2F
	5mo4PA3Dz/3LSLqSul4U4bDuHC8mXq8NdXc53fGKWrxoI2bwbiala3tWNtSfeggHvkX504zzeFv
	qgWOlIRszB0vvFid90sD/P00B1yYl0c3s3C8eHSdyK3+XZhmQxdGABfW4qHP4KAmv7eEf6Ad81b
	I+tnGROZIW8exMWZncuUP8CsL3r4lUHcCuh6YWm4EQxH2W9Iu3fbTqWoYQLc6SqOaRUWLX/wVZK
	55dGo47RUiyO+k3VmCfKKY/3rBaTk1TDn0DSwWkUwiYWndIV88zSXIJJVvgz+b96TtSF1bI89hL
	sXWOLgvD36XUuKUPDPnbvqoN08b5RoQD2O/pPUCNiAwJMjpS13/pOlCCLnHeYWShoSNq8Q2bRrQ
	b77SjBd6awGsEaFyy+eBgizJFGj3av1sYWtkcjCgZq1ouVFCNT/z5zubZuHJJQsgMIrexzp7SqK
	SwrqXKZfZXopqyKkO84Z/I2OfAmWw==
X-Received: by 2002:a05:6402:4244:10b0:69c:83f3:4831 with SMTP id 4fb4d7f45d1cf-6a063f622a5mr16396a12.7.1785319692673;
        Wed, 29 Jul 2026 03:08:12 -0700 (PDT)
Received: from google.com (250.192.189.35.bc.googleusercontent.com. [35.189.192.250])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1f83f4dda2sm89863166b.36.2026.07.29.03.08.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 03:08:11 -0700 (PDT)
Date: Wed, 29 Jul 2026 10:08:07 +0000
From: Mostafa Saleh <smostafa@google.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev,
	Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Jiri Pirko <jiri@resnulli.us>, Jason Gunthorpe <jgg@ziepe.ca>,
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
	Jason Gunthorpe <jgg@nvidia.com>,
	Michael Kelley <mhklinux@outlook.com>
Subject: Re: [PATCH v8 12/23] dma: swiotlb: pass mapping attributes by
 reference
Message-ID: <amnRB98ZZIysHuM3@google.com>
References: <20260717180442.110954-1-aneesh.kumar@kernel.org>
 <20260717180442.110954-13-aneesh.kumar@kernel.org>
 <ami_mpd_1pF4Tmdu@google.com>
 <yq5a5x1ygo7z.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq5a5x1ygo7z.fsf@kernel.org>

On Wed, Jul 29, 2026 at 02:35:36PM +0530, Aneesh Kumar K.V wrote:
> Mostafa Saleh <smostafa@google.com> writes:
> 
> > On Fri, Jul 17, 2026 at 11:34:30PM +0530, Aneesh Kumar K.V (Arm) wrote:
> >> Change swiotlb_tbl_map_single() to take the DMA mapping attributes by
> >> reference and update the direct callers accordingly.
> >> 
> >> This is a preparatory change for a follow-up patch which updates the
> >> attributes based on the selected swiotlb pool. Keeping the signature change
> >> separate makes the follow-up patch easier to review.
> >> 
> >
> > I do not understand the point of this, why would
> > swiotlb_tbl_map_single() force attrs over the caller which should
> > already know the context (whether DMA is shared or not) which case
> > would this be useful to force from the SWIOTLB code?
> >
> 
> The mapping request was for private memory, but the device could not use
> it because the dma_capable() (force_dma_unencrypted() == true) check
> failed. As a result, dma_direct_map_phys() allocated a swiotlb bounce
> buffer, which is shared. Since the DMA now targets the shared bounce
> buffer rather than the original private memory, the attributes must be
> updated to reflect the new shared mapping.
> 
> dma_addr = phys_to_dma(dev, phys);
> if (unlikely(!dma_capable(dev, dma_addr, size, true)))
> 	if (is_swiotlb_active(dev))
> 		return swiotlb_map(dev, phys, size, dir, attrs);
> 
> 

But it does not make sense to me to have it in such a low level
function, and it shouldn't change the attrs that was passed.

dma_direct_map_phys() is the right place to do this it should set
the correct attrs before calling swiotlb_map().

Thanks,
Mostafa

> -aneesh
