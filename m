Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D874D22F15E
	for <iommu@lists.linux.dev>; Fri, 21 Mar 2025 18:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742581543; cv=none; b=gwyTpiSNbQp1CbTJVd7Gm9iLJ+ggXGXe9jEgV+rT4hOg8VhU5Ee1q9S2Pt9iDsOBKJKHnMYOfxQxeQZWxIyZX9Gha0U35IzvGsyvjhJHW96P6ojhl5YgtF1EhnjcLEuS1ZE4vhxDgx2yHGste+CzhbC3H2+4cPCf1O8nqI7fj3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742581543; c=relaxed/simple;
	bh=jemg1ODGg1pK6bsHf0OEdD0dT3yUnEMJLXk8hBjZYxE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g2cqi2kCZGKKM3eDjYw9AC5qSuyV6zgD7UZWV3uRtNlw+RQbjrXIHti4npO7odKUD3XA2X9sLOTMfufyz7BosJHwit9+dp5OYrwuFJTN7whLTByJhgnOznMms9BSy4YsiSZaEMapPcgT+QZn2B3s1BLVzeyrtox+k0W+plHEgqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=AkC132zq; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="AkC132zq"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6dd1962a75bso16747826d6.3
        for <iommu@lists.linux.dev>; Fri, 21 Mar 2025 11:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1742581541; x=1743186341; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4DRNDu+mZPYgGquCy2SeZdyPfdQyJHb3d44tNADVang=;
        b=AkC132zq+srxD1IqwsT/IPROplJjOBV8L8L8LDZYkWv/Yqravh+msq6+iloskmLcty
         Juk9XprhYwZsULahjaaVM4HH9k7N3I55csD2oqh7jrIkR88ffzjS2MFUK6sheaWy/KxF
         kKcFmKOARxgNhXxBiyPrPjyVnGutyu9s4YiHHM2z8Fdk+4FqN8itXSn0CUUzpRH+ICZX
         eBqBVQSjtixeVQj+BADN9A0HyduH8IOSnftgDy7GOEN+mXJkTJEBZPMFFOWeMz/CCwOk
         hG4FVk3wn2QB9yYFV/oBDogmojuXhpjCcD+89hec4f9BjamDz7jXkUm2KtUcCjUmBSBw
         ffdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742581541; x=1743186341;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4DRNDu+mZPYgGquCy2SeZdyPfdQyJHb3d44tNADVang=;
        b=IwrVBR7E1VZDghJc/qk6fFbd//UNcyrDo6jfwrlPxPpWs6lXGQovVLsYfPPIac/2ya
         Wbo024FBUPxQQKBGNQUmXM4VThvwSupCAgYNVn+wyrT5alPTfiDOXHocuBwFU28JZiUH
         TKyej5Ggmt9z2MM/HqBwguYeXZYR3yRBxW2U+VI/OAKd1GhIM0imSxGkA+lf1yQ5KoQf
         7PPSwAwFXVr0CmfJTXeGa6xzWuGf2ZQpNU+rTIhdtJxdDtNlAi11io5AH2QYDX06OkmL
         7enNRPEyCqDF14uv1dR1SGE3w3Lrdk63ljha9TRmP+p2nejbdz7fzWjoYxNZCGwu6vam
         q+MQ==
X-Forwarded-Encrypted: i=1; AJvYcCVcr22Uz3RXm7BvV1XO+5E0djVreT8f2j4/VsOeyNYTqRWb91sU6LWQrjktAy4ok+P37E8lQg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyiyPp7pxAcmKafuG8ry+C67EJ9aMqt/GLmTBvstsrxJmjFJy8Q
	oAQiQIgCZ/x0MWQkmj789dJOnH6Sbf1PSrbVNnqonpzJ8cQ5aUR/c1S81m/TB9w=
X-Gm-Gg: ASbGncvUgIXpgfqeSnhIVZObm+az2b2fSnh7xFvlVave7TxU8VMxEdzi28TnRxRCIMr
	pCs8UpRnHlwPSftmHhHI+AoW94fvFjWd6qKFACvORgUtDCpETcEswh9bMNZr4Me2R5v3NfvdKYI
	1iDAfHBlyL+q6szdXIRrHf6aAYANoQzwcPMgfGdSO9Z+yMqRPS3r8n3/4ry5dE0fPbTxT3IhiHk
	whmI7KbD423q+XMuRTjz6/qaE+EJRmp7RC79CxTCejdc10xHVBNZYqZdpm7TLrk8RR2RyvCYCuS
	Ti56A4gITxWKaGaPjdQtwJ1VbmAW1U7xQ5KMEH6Vl96CFzQjSF2RTT/e/LBQky/H7boyJ0qHDF8
	28v45H9xHX95WvR2JBPoVMRw=
X-Google-Smtp-Source: AGHT+IFpNIlarhIX3KQ1uNeuExxcnUQwaoKxWUOhP9ifvqi6wUM9+9o3gFTu/dM5lv3aP3HzJCq1dQ==
X-Received: by 2002:a05:6214:268f:b0:6e8:ddf6:d122 with SMTP id 6a1803df08f44-6eb3f294de9mr65457026d6.3.1742581540524;
        Fri, 21 Mar 2025 11:25:40 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-219-86.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.219.86])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6eb3efda6ccsm13609536d6.113.2025.03.21.11.25.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 11:25:39 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1tvh3r-000000016XB-1iiC;
	Fri, 21 Mar 2025 15:25:39 -0300
Date: Fri, 21 Mar 2025 15:25:39 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Abdiel Janulgue <abdiel.janulgue@gmail.com>
Cc: rust-for-linux@vger.kernel.org, daniel.almeida@collabora.com,
	dakr@kernel.org, robin.murphy@arm.com, aliceryhl@google.com,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	Valentin Obst <kernel@valentinobst.de>,
	open list <linux-kernel@vger.kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>, airlied@redhat.com,
	"open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>
Subject: Re: [PATCH v14 02/11] rust: add dma coherent allocator abstraction.
Message-ID: <20250321182539.GP126678@ziepe.ca>
References: <20250311174930.2348813-1-abdiel.janulgue@gmail.com>
 <20250311174930.2348813-3-abdiel.janulgue@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250311174930.2348813-3-abdiel.janulgue@gmail.com>

On Tue, Mar 11, 2025 at 07:47:58PM +0200, Abdiel Janulgue wrote:
> +pub struct CoherentAllocation<T: AsBytes + FromBytes> {
> +    dev: ARef<Device>,
> +    dma_handle: bindings::dma_addr_t,
> +    count: usize,
> +    cpu_addr: *mut T,
> +    dma_attrs: Attrs,
> +}

I'd like to point out how memory wasteful this is from what real
drivers are doing today when they use the coherent API. Let's compare
against SMMUv3's use for the CD table..

This would be the code in arm_smmu_alloc_cd_ptr()

It is making a 2 level radix tree.

The cpu_addr is stored in a linear array of pointers:

			struct arm_smmu_cdtab_l2 **l2ptrs;

The dma_addr is encoded into the HW data structure itself:

		arm_smmu_write_cd_l1_desc(&cd_table->l2.l1tab[idx],
						  l2ptr_dma);

The size of the allocation is fixed size:
			*l2ptr = dma_alloc_coherent(smmu->dev, sizeof(**l2ptr),
                                                                ^^^^^^^^^^^^
						    &l2ptr_dma, GFP_KERNEL);

It doesn't need a struct device pointer or reference because this uses
the usual kernel 'fence' reasoning for destruction.

It doesn't even use dma_attrs. (why is this in a long term struct?)

So, smmu manages to do this with a single array of 8 bytes/entry to shadow
the CPU pointer, and recovers the dma_addr from the HW data structure:

			dma_free_coherent(smmu->dev,
					  sizeof(*cd_table->l2.l2ptrs[i]),
					  cd_table->l2.l2ptrs[i],
					  arm_smmu_cd_l1_get_desc(&cd_table->l2.l1tab[i]));

Basically, it was designed to be very memory efficient.

If we imagine driving the same HW in rust the array storing the CPU
pointer would have to expand to 40 bytes/entry to hold every
CoherentAllocation. This means rust would need a new high order memory
allocation to hold the CoherentAllocation memory array!

Jason
