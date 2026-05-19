Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B94B048C41E
	for <iommu@lists.linux.dev>; Tue, 19 May 2026 11:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779188685; cv=none; b=jnUWZKtf+EUO5KSijipGcGfRAuxN1t8AnrsDTn/daEInzopT5qrW6N1rdZJu87Jrd7ZHFnTlBsvvClWobZitLPdqe+/9oPmJfkHg8hzNRub5fnPy1TN6ArFKGtnsbJWfhERbU3HkSDtdQNzqJR8Lp6dQ0IHZ31FnRbklnUe+kec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779188685; c=relaxed/simple;
	bh=2SFj+tqay546Nu3bNSVBDfQbhniYkrhXCx7X+rN+iPo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aQA43R7KmQ4PEb0sIhSVkYFhVHRa7ZezEro6H77dV5agDzkFkEML3+TL5bySgAsLfFIH3+c3arK5Th9O1Ha3lcx5lqn1LWdKPQvdA/twAmfkB47smukg5FVRw7P1KpgdGDe93znJ0nK04Lkk7G2Njjp7c74YYp5oeKrNE9lSWrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gm35K8rW; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gm35K8rW"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4891ca4ce02so695e9.1
        for <iommu@lists.linux.dev>; Tue, 19 May 2026 04:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779188682; x=1779793482; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=a+e/82ARLCMhJAFToMBvP+HlY35DA3/x25Ks+dxKl00=;
        b=gm35K8rWa3fjjGxgOnH9Ibe/wepAu6DWlHrTsWHgLIltMkkiqKPcVc/d0Hnxo3Booc
         6hJBppkKdd7oodAwbwvpr1R73Rqiulps5RtTN/zF/GT2hnDBZ1smBKi9WBk85JT50q3o
         GeJ2tqOhnlTfasywryHYTgQGcO8EnQ7nVc+TELffWcwVTkkBxGw90ktMRhC/eyIfivXa
         tAipHwUdSgNJxEDD3svZie+StbSP66w4Sn5m9FNpPyuLyHuDkQD0wOw9v4xW9n/DoOQR
         VpXOqtPzyDbHziKpGKw+XFqvJ9Uo/O3cZQn6oHuV3aVqkYB02n7bSuxmQVnfVpw0yB/V
         ayOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779188682; x=1779793482;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a+e/82ARLCMhJAFToMBvP+HlY35DA3/x25Ks+dxKl00=;
        b=r31IGsMtzo3wqLUPVsHNDcAzVfQu8nvjZZGgFsDqElzRMzFgTXpd4+g+I5xY7SQsf8
         N3aq5nvdLbl7TBLOZAyj95wx4cbINQVnLur0JW+6KjxuYtudIOtM2kJIQYrnhrhl7tbM
         bFQGDdylXi7l9SRAQY6VTl9GnzYOVEuH42CRSb0m8wAk16KudFpIxlkr2kiq4UY+w1oC
         JbNnbKqkn7a4GFsHxXvl9HOGkUDWrqzWXRINc0yZUONVi8dSiRhjoY/j2z7Ob0Pt0akf
         AS+M+A2qf5cw2uoOk9eZilwJaixgYnmdgie6jpd2h5OA4nJVseAP5T/MUy2PTgZBkxSQ
         y2sg==
X-Gm-Message-State: AOJu0Yxyh9TFYJi1HO906FGrwOzvEWugAUvsnvb89kn7PNtYVvTtTEAS
	fdC+vQ2lz6QUXwbMY/4s5ZPJBxmc614Emf6wz0Wr15yiLMfFAOqLzw6NGNcy0I9tew==
X-Gm-Gg: Acq92OF/ylLPadHGT4MykUlAcwiEnjrql/8IRjLVytw+g9ByGIpkFDWLfD5ECThC5OK
	4ff2HSQYdbfqLeCOq5Zaqfh6Ua5ink2QTQ5Z9VA/nbYvxLf33PSQNN70eGzqpB1aCKdFXjXSm+Q
	2l8ZxJ6ullvxzNxiONq4LvbUhKflKu0t+sm/fTUV6FfvYMGCfuklqRDXO/WCMgTBzzs7fbFofpP
	1qom+daYk5qMDuoJziKY+Ypf5AoyduFAwfsGzEavEl7V5ofRlK+VlMqDcCEsixIzKSITWQxkrCm
	F4giiIYhzfine896WygNYxNxFWmM3kW9dK9q4Cfekhm4Qs4a9cJnCh6DdvETlOleyh3M9k8jLJC
	cSWNNzAQE5+KhZuzIzHqZqTN2Ti/+eh1GaN9mfJW60pyx4CZS0rDkj7Z6IQhReX1FHxSzkOaSqW
	OYusO9thO6P9OF6ANSsZzC5cCSMxiZhJlREgL6uRojIs/D7WUoE5mMD0HfURb4Y9SFx2Miwu4Ef
	M43fG7GvYLZkA==
X-Received: by 2002:a05:600c:2183:b0:48a:5d95:d33e with SMTP id 5b1f17b1804b1-48ffa5d593cmr2833855e9.6.1779188681631;
        Tue, 19 May 2026 04:04:41 -0700 (PDT)
Received: from google.com (136.41.155.104.bc.googleusercontent.com. [104.155.41.136])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fe4c834besm340461595e9.3.2026.05.19.04.04.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 04:04:41 -0700 (PDT)
Date: Tue, 19 May 2026 11:04:37 +0000
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
	Sven Schnelle <svens@linux.ibm.com>, x86@kernel.org
Subject: Re: [PATCH v4 04/13] dma: swiotlb: track pool encryption state and
 honor DMA_ATTR_CC_SHARED
Message-ID: <agxDxdxynp4KEovA@google.com>
References: <20260512090408.794195-1-aneesh.kumar@kernel.org>
 <20260512090408.794195-5-aneesh.kumar@kernel.org>
 <agSKQrSIhizCXKwx@google.com>
 <yq5ah5oaa63h.fsf@kernel.org>
 <agW5rhE9n2gDQ0w5@google.com>
 <yq5apl2y5f96.fsf@kernel.org>
 <agXaby-7L7yS3Vva@google.com>
 <yq5ah5oa59wy.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <yq5ah5oa59wy.fsf@kernel.org>

On Thu, May 14, 2026 at 08:13:25PM +0530, Aneesh Kumar K.V wrote:
> >> 
> >> What I meant was that we need a generic way to identify a pKVM guest, so
> >> that we can use it in the conditional above.
> >
> > I have this patch, with that I can boot with your series unmodified,
> > but I will need to do more testing.
> >
> 
> Thanks, I can add this to the series once you complete the required testing.
> 

I am still running more tests, but looking more into it. Setting
force_dma_unencrypted() to true for pKVM guests is wrong, as the
guest shouldn’t try to decrypt arbitrary memory as it can include
sensitive information (for example in case of virtio sub-page
allocation) and should strictly rely on the restricted-dma-pool
for that.

However, with my patch and setting force_dma_unencrypted() to false
on top of this series, it fails on pKVM due to a missing shared
attribute as Alexey mentioned, as now SWIOTLB rejects non shared
attrs, so, the DMA-API has to pass it. With that, I can boot again:

diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 5103a04df99f..b19aeec03f27 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -286,6 +286,8 @@ void *dma_direct_alloc(struct device *dev, size_t size,
 	}
 
 	if (is_swiotlb_for_alloc(dev)) {
+		attrs |= DMA_ATTR_CC_SHARED;
+
 		page = dma_direct_alloc_swiotlb(dev, size, attrs);
 		if (page) {
 			/*
@@ -449,6 +451,8 @@ struct page *dma_direct_alloc_pages(struct device *dev, size_t size,
 						  &cpu_addr, gfp, attrs);
 
 	if (is_swiotlb_for_alloc(dev)) {
+		attrs |= DMA_ATTR_CC_SHARED;
+
 		page = dma_direct_alloc_swiotlb(dev, size, attrs);
 		if (!page)
 			return NULL;
diff --git a/kernel/dma/direct.h b/kernel/dma/direct.h
index 4e35264ab6f8..8ee5bbf78cfb 100644
--- a/kernel/dma/direct.h
+++ b/kernel/dma/direct.h
@@ -92,6 +92,7 @@ static inline dma_addr_t dma_direct_map_phys(struct device *dev,
 		if (attrs & (DMA_ATTR_MMIO | DMA_ATTR_REQUIRE_COHERENT))
 			return DMA_MAPPING_ERROR;
 
+		attrs |= DMA_ATTR_CC_SHARED;
 		return swiotlb_map(dev, phys, size, dir, attrs);
 	}
 
-- 


I will keep testing and let you know how it goes. If there is nothing
else required to convert pKVM guests to CC, I can just post the patch
separately as it has no dependency on this series.

Re force_dma_unencrypted(), I am looking into a safe way to use it
for pKVM as I beleive it will be useful to eliminate some bouncing.
However, that’s not critical for this series and can be added later
as I am still investigating it, if I reach something I can post it
along the pKVM patch above.

Thanks,
Mostafa

> 
> 
> -aneesh
