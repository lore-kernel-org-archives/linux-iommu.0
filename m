Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C230B35201C
	for <iommu@lists.linux.dev>; Tue, 19 May 2026 14:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779201333; cv=none; b=YXg/WMl8klBEUeIMXv4wb4jkgpDMY6TLg5ZvpdodF7z10u2304vhM3CaM+OqIg+WrMB1xbYnsQJ23cEqb5ZaqqoGhXF6iUpvBFT9LOTta9hL2DB+gVZc1Vr+RkwQFvhvqRKWYsFGVg/cL0UKMrOdY3WrNcy/QwpKnSRpJBVhnNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779201333; c=relaxed/simple;
	bh=SrJusYoqDcdUKkci3L7v9V2XCvsCIXynjFVOmsBOWE8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mkfu97tmi0GQxRxtgmRYCPaJHGHTnPlIj0nKNKpxUK5Rhhr7gRH/v330dptBg0h4ritiTHt0iPP2wckP2HbkHQgrJxGicHxCqs9s4a2n7cdC+fAGj8ZA3iTuVyiYAeyRpvuUJmWO7NDgCezdFM915KVYK+Ir+oMOJ+5m7yeuDKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=fyA3hkxu; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="fyA3hkxu"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-90d042fa745so655281985a.1
        for <iommu@lists.linux.dev>; Tue, 19 May 2026 07:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1779201331; x=1779806131; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oQZO5nTRmEQFRCy1SP5NN6DtrD69wZAHlR442WwrJB4=;
        b=fyA3hkxugEfTfIebzWbPdNvTuz6dvVq+lazElDdASCoS3M7LFXb/fBJFeY7XOoDGRH
         zrrNxYSggPFQsgkj9bxIdceMIrMMT9Bj1MvPjDYWsv1Km2U7VrJPrRtI89ee6XOhPCQD
         SoyowqoQJ2zD/kJ+Y0NyhDv1Ig+NnYvZcc2jLNqjTLUUxuhZmryeXRhl7NEhBEBgRZ3Y
         /IKBBcq1u2pHzLSjHcnlXqP0DdXb0Fwa789/ZZGrqgm3DXeOwc1StwWu4YQkk7Hf3rei
         f1785LNGOWKhPq/izBt9XWYrJrSp4z2cvXFU5finYD7WASi59Mq5jSj9cnMMTKogwFtg
         LQ4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779201331; x=1779806131;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oQZO5nTRmEQFRCy1SP5NN6DtrD69wZAHlR442WwrJB4=;
        b=DyASYAbvIg/axqzdz1RibicCx0dTC+w+1WQ2ESrf73wcIFAYJs9AdBExmsrVU+uf6j
         A+UjxkqeMwRtIgA/RvCNMOWEZ7XG1MTXEprEpxZ/IvcHUD12+pKccFZjQ/QwQdduFO8m
         FN5lqu+rxuK+Lp3BYpz2VKotejmUcEHaOIcVVzuFB+ZeNbLgt+umsQGEtINP3LH9fZKu
         M8zfEMeczkJE5NrM9LD/n9x7dhAwlzDlrB+GwZfdxILFvy6nb57PDicfV1ujf1UPhiZP
         96Vzv6l916r8bv2GavZIWy8KQwmJEHcQbNlaCno8Gaf8loUYIxqheYhvaHj1QtK9VzmE
         d/Rw==
X-Forwarded-Encrypted: i=1; AFNElJ+9bCSdPVpYIoKkJZhaheY2iRC4z+uKsUaZrw7gyuzDgsX5s/mLZq34uB/eLBJdOrSOKAdS0Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YwZ2+GX9MOaAOGDfDQHbpHR9qrEMpGF3yb/Qz/8FQuc592KVP7x
	HAQz6cuD2TTclRRx4eOL3W1PHRzBDfM+7ibszYGbWE2mZPMZlLkNTcb+CxU90FNhsNA=
X-Gm-Gg: Acq92OFl84gzsv3/ugPw1Zj0btWx4aPkF7dl/iphS7O1hwQ+yLKxOGE2vxs1lshyhNF
	dfyS6rmcDqvSSfrEh4mxKfxguXwvgRzUl5juAXapj3VI2RGDB4KQbPSsyHAt26a+sdhE8FfYyvY
	PmaboF1fvd30+US99oKGoyEAodYip8aJjDVyAlGDP+63Lhsc3dCQC8pTv6t/IgqOK1yeumswPn9
	YkxRsfQuXH7SaQH6GBk6EobnDF2SrPoBY0Rxbi6AtclsLac3Tam41kI1UGGFa2P/J0mcVgvT1Pa
	RvrfoJqJljh/FaDIcYRP/AxtCOMtgyWKY7T3ceelOBRP3L6afAeLyjjVPfUWXgX/18fb9KwrMt6
	xsmoYRuk8c6FT7rtkwSN25RTiAT+KjYM3WA1Uag4Db0Qf+SA7Mr9UOGAvYomzlgE3IgcvO646oW
	hi7h7Ofz2Fb4XFy5VvUkZ4Gy6hqLp9EPbLeARVFvNsqicXH8Ef2YehPl+2RYDOCrU4NdDhrpltn
	nj9pA==
X-Received: by 2002:a05:620a:d8a:b0:913:e5bb:3db6 with SMTP id af79cd13be357-913e5bb548amr1506341585a.31.1779201330581;
        Tue, 19 May 2026 07:35:30 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-910bc83ff00sm1849026185a.26.2026.05.19.07.35.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 07:35:30 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wPLXd-0000000F7pa-1dCL;
	Tue, 19 May 2026 11:35:29 -0300
Date: Tue, 19 May 2026 11:35:29 -0300
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
Message-ID: <20260519143529.GD7702@ziepe.ca>
References: <20260512090408.794195-5-aneesh.kumar@kernel.org>
 <agSKQrSIhizCXKwx@google.com>
 <yq5ah5oaa63h.fsf@kernel.org>
 <agW5rhE9n2gDQ0w5@google.com>
 <yq5apl2y5f96.fsf@kernel.org>
 <agXaby-7L7yS3Vva@google.com>
 <yq5ah5oa59wy.fsf@kernel.org>
 <agxDxdxynp4KEovA@google.com>
 <20260519132911.GA7702@ziepe.ca>
 <agxolksC_1nfO34X@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <agxolksC_1nfO34X@google.com>

On Tue, May 19, 2026 at 01:41:42PM +0000, Mostafa Saleh wrote:
> On Tue, May 19, 2026 at 10:29:11AM -0300, Jason Gunthorpe wrote:
> > On Tue, May 19, 2026 at 11:04:37AM +0000, Mostafa Saleh wrote:
> > > On Thu, May 14, 2026 at 08:13:25PM +0530, Aneesh Kumar K.V wrote:
> > > > >> 
> > > > >> What I meant was that we need a generic way to identify a pKVM guest, so
> > > > >> that we can use it in the conditional above.
> > > > >
> > > > > I have this patch, with that I can boot with your series unmodified,
> > > > > but I will need to do more testing.
> > > > >
> > > > 
> > > > Thanks, I can add this to the series once you complete the required testing.
> > > > 
> > > 
> > > I am still running more tests, but looking more into it. Setting
> > > force_dma_unencrypted() to true for pKVM guests is wrong, as the
> > > guest shouldn’t try to decrypt arbitrary memory as it can include
> > > sensitive information (for example in case of virtio sub-page
> > > allocation) and should strictly rely on the restricted-dma-pool
> > > for that.
> > 
> > ??
> > 
> > Where does force_dma_unencrypted() cause arbitary memory passed into
> > the DMA API to be decrypted? That should never happen???
> 
> Sorry, maybe arbitrary is not the right expression again :)
> I mean that, with emulated devices that use the DMA-API under pKVM,
> they will map memory coming from other layers (VFS, net) through
> vitrio-block, virtio-net... These can be smaller than a page, and
> using force_dma_unencrypted() will share the whole page.

force_dma_unencrypted() should only trigger swiotlb and that never
memcpy's more than necessary?

Where does it do otherwise? That sounds like a bug?

Jason
