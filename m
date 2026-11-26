Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795710700;
	b=ewG1sYRDwXwDqIi8k6DZVyp9/5M4Ms4JPEzkXrzzIAdtyLIitOaqeM1EI0SaspuJC0Yk
	 jMa/D1B5AhdomhBLJQ4Hq3mUztgZbWoRpmyiUcbjrWoKTohBoF1pISCJZtX+UgOcg6Nxs
	 6s37PbSV/4t9HhzN6KY1uvir6pkCo8JQkXdA1dpTqRHWtZGfq/b8YjFfA5rvMG+T/+Ac9
	 fWDpnVviOAA4c2MT6/OeDsEiqW5DsjRRHF+XDm5QICTw7BJOTmkc7uzAufLBkjmTlrBe9
	 Y8HwQJzHMCZMrBJM4n0McCEimxUOO4uFXbgVuBgGvu5GHy829DkPyQqnRlbibunZ8rA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795710700;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=mKMGXbvF/sfX9s9vl5jaq/5p/tKCIj66clg+e7onQEc=;
	b=4ZpE55pJj920I9CSUGJjQcu/xC5RpxRHmR8qzlfoiws9aHIpPyJihpt0Gh4HPjbDfJe+
	 /cYzJMRkdthx2noAajZdSieCjsyTFIu77X0DOt1BB7/qPOjN9YttES9wPkUb85uqj+FwT
	 uyeKTFbRE8YcG3ZBKaDVqOa24kt9uhxGNRBNGksIWLrKTQ5Zx81+0K07fyg4yYCQRWvsg
	 6YCV+sNjh7aepnSHMPMILhbsjw/Hh/2hYkEZfJgkAUASxBIOfKh1xbF9RcGEzWEOKpgc/
	 jgCQOc46mtHwEpcSqY0rCwVePgSP9wzV2BgHNLDR8M7cgqElKhcd9zOWKbmFHN5PA6g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=USPS9Ylb;
	arc=none smtp.remote-ip=74.125.224.44
Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D672606A327
	for <iommu@lists.linux.dev>; Thu, 26 Nov 2026 16:31:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5D672606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=USPS9Ylb
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-67c0bd676eeso5085038d50.3
        for <iommu@lists.linux.dev>; Thu, 26 Nov 2026 08:31:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1795710699; x=1796315499; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mKMGXbvF/sfX9s9vl5jaq/5p/tKCIj66clg+e7onQEc=;
        b=USPS9YlbJy5Ee1rwwfQWEP3Ve8SszpGtAS0zjskI9LSW4enHGz0fXGUdGEm+LK2972
         q5LEmzTswauSlTatatKd33PcPM9u4+158FxDRvHWjqXyxYoASoS6c6YPM4TnF9urJ9MT
         IgmM4Gx6HK1qbaace+7wbEhWbBvqwSlSxnTJ/VhiO+YuRflew2gVqOgI0AOLx5oHFA3P
         V9PfQ5ful+N5KDidIg9e490r6aQNC1G82sTszz84kN1NtqcivRgxNpkmynhWJh5GO0a3
         EiyKr0vW8w7uPEpUkoyVl8SOBLtSmxlEIxgA7DktcODzrb+DhrdQZ/UOwSfE2AoNrqVd
         veMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795710699; x=1796315499;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mKMGXbvF/sfX9s9vl5jaq/5p/tKCIj66clg+e7onQEc=;
        b=tmsF4/ZbcEhl1Vkw0iFbS3IKgIrTXlYBxuU0GsB9vOTKGV7pLVeg3E8Ah2x/X5ndWe
         JTM8crhNtRq06/Wu4Yh4YWC2jL63yvocOX4xmV/lKuazhK7M6d9Wt6w9+5+nf3JpWEdv
         upIkLNPelCuJbqwiOK1z36GQKDO9joVaoV+FEo5UqnrxER6MR7IJ3xrO/mg3G25r7vCX
         SentKcaC9HL4WBm76iaFBZmAh/v/uaSG3Ii+LSzPseyZLDiB564xt7WbmQB7OsefcDEh
         Nt1oxvg3oaQXabggszSIdTlEfSZcbhxU4fMXiYPqXK7cPW7YATkqvB7ZjF+MO79EbG/+
         +Hog==
X-Forwarded-Encrypted: i=1; AL+hErF6KLQNTV78HmJOOvnleBxhCZAISWh4KWDDr+OzBevbD2OrlLjpOMNXcVNJyJOql3ipELGo/Q==@lists.linux.dev
X-Gm-Message-State: APuU4Z/meWfYCsr7TMG9UKw9IhQKvEMDlGBp6dAV1k9pQNLZz6Ny9RGk
	D2TkKljtc4HOmbRQ3VoVDqKPWu1TDYOM5U9CGsTHznhyGFEFOohtQAwewhaqz0pepAg=
X-Gm-Gg: AZFdTZdsWQWAksc1jFYHmIWVNHNfXYJLzYTJ5GBvEjZzCTHgzmGxUbsCA3Zi61XftEV
	UbItSynsy9lpD+0tRcgYiwkJOIvmsY/xCtMc+KEr8BU4mOyWVYYU3+7qGlx0kSyKLn85oMnMdI9
	7e563VAFVdtyPtVHc/Fe+XDnzsLC/29+b2wjjtHg2W//PAq0S30YlXKKNL63QueurIU0v1ZhLxN
	GQHjbK/I2Dm3VN3qsjHuiLeuYtfrYzk9v3iBNHwayeKKWYhMZTWcbF+e7AQOUetAmR94KitR925
	VGH1cK2nWN7jnApLGGogXWLZN+00pXqaGVPZVCP7IME7LRhPhNNoNvvCJgY63+zUQe9xBZRNQl8
	va7QSuro0IAFq4BXFbEKJhu7LDoaAQ2be4BJmrBYNbQm7BGAurGNDwxKXtIKe3hUq87Qe24c8iC
	tl40G7eijsxiEp1qoej7sfKebCpfrFSfincTmGpjwCcLOAotEA9DuZ66YImEotMS65KXRHzhaMm
	7jO5CEE65OORWtQpBEKSw1XBfY1QWVJL9APvAn7THIdSEfj5arTC+Se1UwXwFhD68TTobAYG094
	qQS7LQ==
X-Received: by 2002:a05:690e:13cb:b0:66f:c1be:a64f with SMTP id 956f58d0204a3-67df4444c30mr10219064d50.65.1795710699306;
        Thu, 26 Nov 2026 08:31:39 -0800 (PST)
Received: from ziepe.ca ([142.177.118.84])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-92134a15b99sm192865986d6.38.2026.11.26.08.31.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 08:31:38 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xWcNl-00000004WQW-3ltS;
	Thu, 26 Nov 2026 12:31:37 -0400
Date: Thu, 26 Nov 2026 12:31:37 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	linux-coco@lists.linux.dev,
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
Message-ID: <20261126163137.GQ246011@ziepe.ca>
References: <20261116091137.94252-1-aneesh.kumar@kernel.org>
 <20261116091137.94252-5-aneesh.kumar@kernel.org>
 <awQd81MwZqi55gf8@arm.com>
 <yq5aa4mybbmv.fsf@kernel.org>
 <20261124134621.GI9566@ziepe.ca>
 <awhVoDXluqpncgcd@arm.com>
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
In-Reply-To: <awhVoDXluqpncgcd@arm.com>

On Thu, Nov 26, 2026 at 03:52:00PM +0000, Catalin Marinas wrote:
> On Tue, Nov 24, 2026 at 09:46:21AM -0400, Jason Gunthorpe wrote:
> > On Tue, Nov 24, 2026 at 07:00:00PM +0530, Aneesh Kumar K.V wrote:
> > 
> > > Taking Jason's feedback into account, we could have the allocator
> > > request compound pages and recover the actual allocation order with
> > > compound_order(). That would avoid passing an order to free:
> > > 
> > > void *alloc_cc_shared_node(int nid, gfp_t gfp, unsigned int order);
> > > void *alloc_cc_shared(gfp_t gfp, unsigned int order);
> > > void free_cc_shared(void *addr);
> > 
> > It probably shouldn't be order here, that is hard to use. Just size_t
> > len
> > 
> > And round up internally
> 
> Minor point in favour of keeping the '_pages' naming and order is that
> it makes it more obvious what alignment is returned for code that needs
> it like the ITS. Otherwise we can just document it, I don't have a
> strong opinion either way (only that it's simpler than what was proposed
> earlier).

All our allocators return things aligned to their size, does ITS need
higher alignment than that?

Jason
