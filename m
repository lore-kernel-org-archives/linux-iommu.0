Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB7F23D75B6
	for <iommu@lists.linux.dev>; Thu, 21 May 2026 17:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779386066; cv=none; b=ui+wXj9uDQ41x8qxlWmckn0ow0R4Cf9gMHfheiqkP6EJse5QZOUdwZHIzQsDOMuTIJt1kx1oi/XoE7UM0gFOR2rp4i8Rmq6qrdv/cYMrAM7F8vLrhpyLXLxF55XjJ1EfnsEFFwRFy3z/jYYFA3gMR/uU5UEzgjuWUeSKDVkLO3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779386066; c=relaxed/simple;
	bh=n2LNy9P3hRcmCt1g1+q+u9azF2YECAgiA8jjB7pwYI0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BxG0G0GfvWGrMMyg4306xJmS1DEbZVNN8x/TDNXq4WfNG5MZMkSDtAq9WLp7p0t2/BeKPF4ksEdCvu+yNHG50xPP/y8kNLCS3XnB4qKgJ2vZIx+7K8rLglf9mxGLCz9dxwJk0n+IIsoL3LqK+RIhLf227bXO08FqAMFA+GfpZtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=JXEAhYbu; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="JXEAhYbu"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-8b1f2b7f1bcso96683566d6.1
        for <iommu@lists.linux.dev>; Thu, 21 May 2026 10:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1779386062; x=1779990862; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EC6XWlOYSm7qj75HyHmp0T60BsFS50VL7KHJNUynWLU=;
        b=JXEAhYbubz/ewGL84eH8GYoCP4VKdI84HbLX7b8Y7DQRkYtdPS4bOHx0/to0i4prbr
         XChLmJd6tIX/Hfd65sATcqA1jcPiVUE8TWYXrVeZs1DB90D1g2btH2tQDuIfvzp4cY1m
         JnKE/NlTXOdf8bl97/AS+F5gn6mNff2nToaRXdUwitsSvHeoXKeiLt4grRqXcjcbJQf/
         ulfSUdyEMZUjdmPVdmv83jbf31/kkmd9vjFpnLanaoC6U12jhoIa6y+rPnsYC/qXw3kI
         DXRx6mFF+/6S/GlTOtewncG93TIRum1NrvT2dfK3Nj+F633iYCAGLUO7ktiNK2a4o1uM
         p8gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779386062; x=1779990862;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EC6XWlOYSm7qj75HyHmp0T60BsFS50VL7KHJNUynWLU=;
        b=NxZ5r61oLPpfGX5/WcGoQuF9rUMi1hKfi8gLZJczuxClhFKrDzuVtDBxDyyEzLem6e
         t4EuMJaoePa1mO26u/Gudi+r03TFV/bgaEyCmS/JDZx1b48xApWABo5AoFo10jbtFXzQ
         mhvrlGCYrsUSqsAsl4hhJRi1MnszsXA8WpLZaKVscKceCW78klTy73TEbYOZ2bAHWtlk
         UOnuIrbwjv03XP1cp33o2dUQT2Mr1/7PjR49SChBpRTdvoAluH/IvCvkLpzTJmA3Wqns
         rxNFOBuDmdO/O3OA9vR3mzQ8xZxbR7t5ofO/+oz9EujJ0r9NjCU5CYKb3ZfmsmiYtWt7
         4L7g==
X-Forwarded-Encrypted: i=1; AFNElJ/AiofiJupIpRYhQ9buBEgQMN1mi3R0OI1rx4f8a3kbtJNC5cOqFBdTwEMCO6ZKGeAO5zzmVw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy02QvOiALPHtzGGgghmzPo5GAM6Uh8RiTfGiHmPZMtlXaZ3IW+
	msAu24lufh8WSUfdBf/ywZn+DoGRSHqi9HmbHNEZOFWojSjhhTgo++R80aypNIy9Ygs=
X-Gm-Gg: Acq92OFY85CSsQF5QdU2bWvF3jsC9QZWl4uNMl84rVdZZRwTG6XFOSMX3b0iWtCBzMM
	5g+sGkTcpjhjGXXiy9cfbnIfZbhBQ/TP+2kUh+SnqrEjOlBYZF+e0K7ytUq061Vo6iRonEfQhRY
	OENLvF8WutpwXUMf1LLUuqyAn/CVOf6KNaUQ95V0l42+tnwBR8B91lmP31Kq/2dBDSr4QNVjKWv
	MZUYP4cHW9fjRSzhmlCEPHpp72iddITRtpDuGXiGStMBD6h2/igxqUQkmLFOKYj+fT+VTqcYsGf
	MVdBficJoMjCm6JlMrmNVBHMRTTMacl1A3jMtSNm0MKc704lS3rKK94DWPhrNoxIZ4eOMyGowum
	gOOo/yrnf0qEnp3SkEnzho+z5BhgTjwYje3RCFWACDOS+buFGVgl5A2760TwgROkn2OE3GMWsB5
	5k0THTmsc058GCh0qjMS7Ru7FBbvYG7exLST0mSHwlG1kozZ2+njd5V6/AASgXhm8QZXl+zSstA
	THHog==
X-Received: by 2002:a05:6214:1c4e:b0:8ca:1e71:c5fb with SMTP id 6a1803df08f44-8cc6e91f389mr49249796d6.7.1779386061667;
        Thu, 21 May 2026 10:54:21 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cc768b6fc2sm11374296d6.6.2026.05.21.10.54.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 10:54:21 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wQ7bA-000000020Ak-1yKK;
	Thu, 21 May 2026 14:54:20 -0300
Date: Thu, 21 May 2026 14:54:20 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Cc: Jiri Pirko <jiri@resnulli.us>, dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org, iommu@lists.linux.dev,
	linux-media@vger.kernel.org, sumit.semwal@linaro.org,
	benjamin.gaignard@collabora.com, Brian.Starkey@arm.com,
	jstultz@google.com, tjmercier@google.com, christian.koenig@amd.com,
	m.szyprowski@samsung.com, robin.murphy@arm.com, leon@kernel.org,
	sean.anderson@linux.dev, ptesarik@suse.com, catalin.marinas@arm.com,
	suzuki.poulose@arm.com, steven.price@arm.com,
	thomas.lendacky@amd.com, john.allen@amd.com, ashish.kalra@amd.com,
	suravee.suthikulpanit@amd.com, linux-coco@lists.linux.dev
Subject: Re: [PATCH v5 1/2] dma-mapping: introduce DMA_ATTR_CC_SHARED for
 shared memory
Message-ID: <20260521175420.GA7702@ziepe.ca>
References: <20260325192352.437608-2-jiri@resnulli.us>
 <yq5atst6ywbl.fsf@kernel.org>
 <4qdizkkoeke3cvkcf35upa7p7ick6s654eqlrizmi7ozkw5eze@tnpk2e34xgwl>
 <yq5awly0d504.fsf@kernel.org>
 <tteiecxfqy4k24wnzvp6ocxnuopyhmqtne2xwh5htwldlbzjnp@o6cbzdlurxld>
 <20260421121004.GA3611611@ziepe.ca>
 <yq5aik9jcpzm.fsf@kernel.org>
 <20260424225514.GE804026@ziepe.ca>
 <20260426130531.GF804026@ziepe.ca>
 <yq5azf1s6aic.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq5azf1s6aic.fsf@kernel.org>

On Thu, May 21, 2026 at 09:05:39PM +0530, Aneesh Kumar K.V wrote:
> I am wondering whether this is better
> 
> static inline dma_addr_t dma_direct_map_phys(struct device *dev,
> 		phys_addr_t phys, size_t size, enum dma_data_direction dir,
> 		unsigned long attrs, bool flush)
> {
> 	dma_addr_t dma_addr;
> 
> 	/*
> 	 * For a device requiring unencrypted DMA, MMIO memory is treated
> 	 * as shared.
> 	 */
> 	if (force_dma_unencrypted(dev) && (attrs & DMA_ATTR_MMIO))
> 		attrs |= DMA_ATTR_CC_SHARED;

It is an option, I would be happier if we went and fixed the few
callers to properly pass the shared. CC did this with the
pgprot_decrypted() stuff, same reasoning:

diff --git a/block/blk-mq-dma.c b/block/blk-mq-dma.c
index bfdb9ed7074116..e77f6404caa3db 100644
--- a/block/blk-mq-dma.c
+++ b/block/blk-mq-dma.c
@@ -90,7 +90,7 @@ static bool blk_dma_map_direct(struct request *req, struct device *dma_dev,
 	unsigned int attrs = 0;
 
 	if (iter->p2pdma.map == PCI_P2PDMA_MAP_THRU_HOST_BRIDGE)
-		attrs |= DMA_ATTR_MMIO;
+		attrs |= iter->p2pdma.mem->dma_mapping_flags;
 
 	iter->addr = dma_map_phys(dma_dev, vec->paddr, vec->len,
 			rq_dma_dir(req), attrs);
@@ -115,7 +115,7 @@ static bool blk_rq_dma_map_iova(struct request *req, struct device *dma_dev,
 	iter->len = dma_iova_size(state);
 
 	if (iter->p2pdma.map == PCI_P2PDMA_MAP_THRU_HOST_BRIDGE)
-		attrs |= DMA_ATTR_MMIO;
+		attrs |= iter->p2pdma.mem->dma_mapping_flags;
 
 	do {
 		error = dma_iova_link(dma_dev, state, vec->paddr, mapped,
diff --git a/drivers/dma-buf/dma-buf-mapping.c b/drivers/dma-buf/dma-buf-mapping.c
index 794acff2546a34..96022fadc48245 100644
--- a/drivers/dma-buf/dma-buf-mapping.c
+++ b/drivers/dma-buf/dma-buf-mapping.c
@@ -147,7 +147,7 @@ struct sg_table *dma_buf_phys_vec_to_sgt(struct dma_buf_attachment *attach,
 			ret = dma_iova_link(attach->dev, dma->state,
 					    phys_vec[i].paddr, 0,
 					    phys_vec[i].len, dir,
-					    DMA_ATTR_MMIO);
+					    provider->dma_mapping_flags);
 			if (ret)
 				goto err_unmap_dma;
 
@@ -155,7 +155,7 @@ struct sg_table *dma_buf_phys_vec_to_sgt(struct dma_buf_attachment *attach,
 		} else {
 			addr = dma_map_phys(attach->dev, phys_vec[i].paddr,
 					    phys_vec[i].len, dir,
-					    DMA_ATTR_MMIO);
+					    provider->dma_mapping_flags);
 			ret = dma_mapping_error(attach->dev, addr);
 			if (ret)
 				goto err_unmap_dma;
diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
index 7c898542af8d5e..e4229b4d35c767 100644
--- a/drivers/pci/p2pdma.c
+++ b/drivers/pci/p2pdma.c
@@ -282,6 +282,8 @@ int pcim_p2pdma_init(struct pci_dev *pdev)
 			continue;
 
 		p2p->mem[i].owner = &pdev->dev;
+		p2p->mem[i].dma_mapping_flags =
+			DMA_ATTR_MMIO | DMA_ATTR_CC_SHARED;
 		p2p->mem[i].bus_offset =
 			pci_bus_address(pdev, i) - pci_resource_start(pdev, i);
 	}
diff --git a/include/linux/pci-p2pdma.h b/include/linux/pci-p2pdma.h
index 873de20a224759..402dc5e5d62b0a 100644
--- a/include/linux/pci-p2pdma.h
+++ b/include/linux/pci-p2pdma.h
@@ -21,10 +21,12 @@ struct scatterlist;
  *
  * A p2pdma provider is a range of MMIO address space available to the CPU.
  * @owner: Device to which this provider belongs.
+ * @dma_mapping_flags: DMA attributes to use for host bridge mappings.
  * @bus_offset: Bus offset for p2p communication.
  */
 struct p2pdma_provider {
 	struct device *owner;
+	unsigned long dma_mapping_flags;
 	u64 bus_offset;
 };
 
diff --git a/mm/hmm.c b/mm/hmm.c
index 5955f2f0c83db1..c3f445acddf873 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -811,7 +811,7 @@ dma_addr_t hmm_dma_map_pfn(struct device *dev, struct hmm_dma_map *map,
 	case PCI_P2PDMA_MAP_NONE:
 		break;
 	case PCI_P2PDMA_MAP_THRU_HOST_BRIDGE:
-		attrs |= DMA_ATTR_MMIO;
+		attrs |= p2pdma_state->mem->dma_mapping_flags;
 		pfns[idx] |= HMM_PFN_P2PDMA;
 		break;
 	case PCI_P2PDMA_MAP_BUS_ADDR:
