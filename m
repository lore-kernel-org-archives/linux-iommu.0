Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795527984;
	b=jqOJYVFD4T4g/I0Nr5EfNorGMV3i3vTTvFV/S/HCE3PgiOIUu8sqEg/02KwCdxKvF9fT
	 00nl9PyCiAeFonj/ScB9OWSY/Idjwp6ODlrZdWNyaSFJ4O/4qrJ9nFaFJKSlFmU2Bzde6
	 cAtIN2yMwFjOH7UkAXnq2TTnpzV4sL6m09qivVrT8J4Q5664EBmbHO6UY95chrPZoZ3hd
	 JmF9y4qPGPPApxT3KrhU5tzFbq/BsUwInKxU64KqoAc2OrFqwXWVFnVJNsPuMM2Um9UEw
	 KpAdd0Q+MhXSnVRquiM7s14UB8MPhVwXhMLLS4mTqRZHdhcber2FizKjSzZhJF3Ih2Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795527984;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=Zc7zKgD/SDYnIbkY4MVpBd0Jo9DiJTva6Dv7og4GVfM=;
	b=SjaL0dRUZGJjApOLI0ZQJzTB1iuD0QR1s6hZbf03GBwe2JU1q5NrGBGQrkxL4urX8RHH
	 qlpJnGXGWADC3zhkmdF/7buWkzzMg0dr6+7An6YvbkD1l7K7QNZEqAoKwGqaph/2pH9gt
	 3jrw+10OjONkc/IfG5bEHnpYVL22HDe69dFGD3lvSA3eHZ1+KZkcEhYKWIj+ILEkf/QCP
	 ZcBlouMA1GbjKtD03W+YVDrfSn4B6yDH6awKE65VVnJ/06P70dQuoM9uoULtnbwBa/AjZ
	 YiWumwAK9cRqHQkeQvCGUIo+nUveMSa70+6OB7obBMdC6rvdc/s+g32agaPd60XhKlQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=EqnpeJwx;
	arc=none smtp.remote-ip=209.85.160.174
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB87C606A333
	for <iommu@lists.linux.dev>; Tue, 24 Nov 2026 13:46:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DB87C606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=EqnpeJwx
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-55d2f5f1e26so51198941cf.3
        for <iommu@lists.linux.dev>; Tue, 24 Nov 2026 05:46:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1795527983; x=1796132783; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Zc7zKgD/SDYnIbkY4MVpBd0Jo9DiJTva6Dv7og4GVfM=;
        b=EqnpeJwx4IAAp9mfsj00WoR29F/1+r5796MPouaebQUygK4aVUnRa6eVS7qXcaT4ks
         Cy1SozoWyb/dvImEqPhS5piGTnA+NT7OFO3eWko2Zh3shjWND6NUhDZZUGTo4his9VU8
         qU/Hj+sBdzclTaKlXDb/qa1g/+8nQCAFYVADWucUf30k7kyCTDmxc9cAiv3P9rg615By
         dIEnYe6/1/C2VpeNnzi0ixjLPEc3Tyfb17hPezkZxync20ieZ/j49+DFoLdPHOqp2D7J
         ORJcbgEnXNTXIZifTIp3/jwUYHap6o0pF353gcrfEyNfbXCqGnTLL65RNrBC4/EEmmoW
         pXeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795527983; x=1796132783;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Zc7zKgD/SDYnIbkY4MVpBd0Jo9DiJTva6Dv7og4GVfM=;
        b=iZlp1L+qUEtO3MT2Qk12IDa232zXP1p9E3EG5Q8hRM9RIZXYOl7hu7GyIdi3kn91OT
         gp1knO5Et0YjqWwfhqT29qFNXx+RprBPFxHDS+vAjvnbL6iAaeJ9ZBVv3iFT4qBH0zyk
         a700YK0IkS+3gqvoeUWXX4SUxQNBnuNhBaylSkv4K1UOkpc/q5vFFlalR9KZQOPwPzS1
         9dyPnRD08lKBySC16/gq4KNrhnn1NLN+vtOq80sHSXGFHjyL7ETb0Ay3oneX3T+UENSA
         SCHEsRPFZL12d7Guw2vtYSW5OTCueTeyg2/b+ADgvKzF0Du9jJ938wLV5v4NOJFI78Ct
         HD7w==
X-Forwarded-Encrypted: i=1; AL+hErEFFhqiWfmWusJ533i9HOthrgsHhwejuIxtr3fymax9bC3ZjkfdcIh+Mjm3RQ2+rATo8lGTjg==@lists.linux.dev
X-Gm-Message-State: APuU4Z8XXLXYxTSKEio388SjiIJFl2FMHNzbLQWbuyNSqxe3ANQ3DS4K
	uonuqMsfA5glnimkmgYFXGP6uvY9gYhmZlhRg4wwi/HKaScPmYfoSdfB55AcOrBbciM=
X-Gm-Gg: AZFdTZeFmP03kxGlzdUgP7icVslHOLNX1XSWCQ7MbkvcRbl1KQ6pSKuXhjNKZz91bm5
	ziFv8wgbck2wiSJpontcQum9eKLW6B7DHcIzdrwwSJd8LX8+svHFe9/+dj0kKrUq49jT8+CwRtH
	51z172G0S2u0iioXEM3rZUE+LfDUZQNKg/7XIApleQWzZKnHImldW3YmNEZImixgoxgJ/xihbkt
	YyEH8P6vUeCNReAjOf2CDAAhSHavYF6JaaK5IcpA+yJadJSHIHaV9m+LM2POiXDfPMoFqoo1bNR
	8QhOPDl0BdN+k6Yk8Y4lZ0huhG4NX1UrhxpdBYNLPfCfLOB18DKS6PXsWKTKcPwFMtNjhAy7OYJ
	m7clVMs8suBn6aTz9sTeLA1mRb3Ez6JJOObd9MocUUcX1dRqFO9lA98tnBFuBFnGB8BJ5gSG4Ne
	QtZitpkRGR1d3Uo4TAd8eovHpRYxfSp+Z2/w7PqWuA3d2C/2D1WMY2aRIAmfqPZ5kDbbbf7AUTZ
	zlq+Yb8H0cXaR4xWUt0BMkSb4HFhd9kfP0c/Jf5JvmBLDIuxHFJHrL1WFy+4SyOLiH+cQTmKvmV
	B6DPTw==
X-Received: by 2002:a05:622a:120c:b0:535:a5f9:752e with SMTP id d75a77b69052e-55d76aed568mr264410241cf.77.1795527982900;
        Tue, 24 Nov 2026 05:46:22 -0800 (PST)
Received: from ziepe.ca ([142.177.118.84])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-55d78451407sm128368371cf.2.2026.11.24.05.46.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 05:46:22 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xVqqj-00000000QIG-3EJB;
	Tue, 24 Nov 2026 09:46:21 -0400
Date: Tue, 24 Nov 2026 09:46:21 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, linux-coco@lists.linux.dev,
	Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <baoquan.he@linux.dev>, Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Christian K?nig <christian.koenig@amd.com>,
	Joerg Roedel <joro@8bytes.org>, Marc Zyngier <maz@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Steven Price <steven.price@arm.com>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Thomas Gleixner <tglx@kernel.org>, Will Deacon <will@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Benjamin Gaignard <benjamin.gaignard@collabora.com>,
	Brian Starkey <Brian.Starkey@arm.com>,
	John Stultz <jstultz@google.com>,
	Mark Rutland <mark.rutland@arm.com>, Radu Rendec <radu@rendec.net>,
	"T.J. Mercier" <tjmercier@google.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Ritesh Harjani <ritesh.list@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>, Kiryl Shutsemau <kas@kernel.org>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	"K . Y . Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>, Paolo Bonzini <pbonzini@redhat.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	dri-devel@lists.freedesktop.org, iommu@lists.linux.dev,
	linaro-mm-sig@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
	linux-mm@kvack.org, kvmarm@lists.linux.dev, patches@lists.linux.dev
Subject: Re: [PATCH v10 04/13] irqchip/gic-v3-its: Allocate shared tables
 using CoCo shared memory allocator
Message-ID: <20261124134621.GI9566@ziepe.ca>
References: <20261116091137.94252-1-aneesh.kumar@kernel.org>
 <20261116091137.94252-5-aneesh.kumar@kernel.org>
 <awQd81MwZqi55gf8@arm.com>
 <yq5aa4mybbmv.fsf@kernel.org>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq5aa4mybbmv.fsf@kernel.org>

On Tue, Nov 24, 2026 at 07:00:00PM +0530, Aneesh Kumar K.V wrote:

> Taking Jason's feedback into account, we could have the allocator
> request compound pages and recover the actual allocation order with
> compound_order(). That would avoid passing an order to free:
> 
> void *alloc_cc_shared_node(int nid, gfp_t gfp, unsigned int order);
> void *alloc_cc_shared(gfp_t gfp, unsigned int order);
> void free_cc_shared(void *addr);

It probably shouldn't be order here, that is hard to use. Just size_t
len

And round up internally

If we ever want to do some kind of slab sharing scheme then the API is
already set up for it.

> As you noted, dma-buf would need virt_to_page() to obtain the pages for
> its scatterlist.

I think that is fine, other places working with kalloc/vmap already do
that.

Jason
