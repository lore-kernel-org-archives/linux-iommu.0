Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF57823EAA4
	for <iommu@lists.linux.dev>; Sat, 28 Feb 2026 00:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772238492; cv=none; b=TtQDwSrctcP/MdXmFvll21YPng2iyuLUeP924QgMLLpN6H0S1yFx+XlGJh670iP9vCYqt/NUW8JmRBJGzFI4q/Y0ly0SiSMXzkdftSOpoC0X1tXkWJwCvN8/TEXQ+NfpIjk6/dfNBh4Z0rtz7XVkafmQuUpbrDuw/ZVOPGCKsPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772238492; c=relaxed/simple;
	bh=YGNKoZbd9ItV0tpLlMFHS8bKihozZyqN701JI8Fx9wU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G6bao6MWIrXZMMyeSaHhxRXcXhwX/XHOIfeE4l7WTAIgHM26Vj6uPkQEsrQhdrIH88A4iJWj6yRQZOymTOdnE5WzM6CVahH7Q/1ft3oRqyROQILGNOVwAyr+xHgZzJggUiBWUwQ4GfwksQQRhlmz6TIXWibpbXGd9NC/y+azZvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=DW5WnZMR; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="DW5WnZMR"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-899a917a4feso44119756d6.1
        for <iommu@lists.linux.dev>; Fri, 27 Feb 2026 16:28:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1772238490; x=1772843290; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KAMLfTB0VdCLmRuczMOUd+4kmAfCR9U6SjigH585Y48=;
        b=DW5WnZMRNLqd7pTj8UY/gLg3v3mRBn/6m1IcTCGwdkDBux4D6RQERavPv9S17bOo2L
         Pt0zIe04B1NDAkqpSNJ6KnwhcbSwCj+stuJYRX/SmVDZdZLJi+ZbjTW8pEFulV5xy0ey
         EiYbYWnPN60CYk1eI+7222GNFKNhrlynIDi2txlzJlj6Y44LTHa+tikOqOtsxJozQSVH
         y+q/OtLrFNk/jHi/dWMQC6ChzMPM+/zitZQFbbfXRVsugQ+TGYe7kOwFQjpAi34vU/0T
         t/s/eUogirQLAC20IXKPJq4NwwhujZDdh6YBSsjaouVUIaqvA6LOE/h2/6g4U4XLtnxP
         GjAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772238490; x=1772843290;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KAMLfTB0VdCLmRuczMOUd+4kmAfCR9U6SjigH585Y48=;
        b=P1lNCxfyB/L6uEpRRtDcG2XkKZzJ1viHCb3UfCHs/M0GoDZY/YPhO4GYtnXmecpIVw
         o3BovnAqNeVhsNUhHM5r1Sduvlf8m5XajKnElu5wysZpajFd34mW5vr9fc9mJRvg4jIC
         3Kz4ahMXOrmkfdrzl8giiNxED+RVxuMMdq3g0kkGmYHFcH7gxlVzq4V3btmugxACO5KN
         HnSAPSr6Qr5OvNW8Etsbrq265oTETODnUVU8JGH8Jlfs4r/Qru0HegU7dVBQxwQ/XmUv
         JjWh08Xh/h3F3JhOoRiFRquuQ5Z02C0b2SDhcgAgTyvfD1fFkrsskGf9ZamanXTfuwJF
         pVVg==
X-Forwarded-Encrypted: i=1; AJvYcCVCHdBn3V0VciHp9ZRcQPFXnP1YfVQ0p4TK1LDXe8u/KbpT4HZgb6mMrM3lYlZ/drOGH6VfiQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyfV3B9wqxE6em/iB6CwUwmD1m9+cBU04+ZYZt2ttBQpJn3AABL
	nHzvhsdlm7yF/tcSqdK3NDvGzHhjmy1vi8kK/cqHIWmnXHPGZuABVWlrXal8xeSs2qE=
X-Gm-Gg: ATEYQzyhWXLpt0XOdfeeuNsqfEEJXJtwZ2L3bmwHssc12vhuTFvFCjK9xk6yJGhatnO
	o7eN1rGfdPSFNHeN0ICHOdAHPuClbiFfyAaMsVrxq2f8RV0V+4lv3730/SK/Cq+1o40MYZGTz7R
	ecduY54nqxZksg1t3cdl6a8wo6KKL/xBMN5nzv7H5TRxrBDAM435RZ9yPztqAm30FVxsjz/5JXW
	de/RZEAUhXGhV8t3FNnK3iiw6WRi+/sL4ppnzIL3a/we7mRRmdXY21KX4ILJg8gLmapGT9bxEb1
	KTtlW+isjAzePe1ejeenvso5uEzZ3wVt5X8Uhc8dDJqnCYdPXMNZI5dYN6CwMbjy5JBQaERQfH7
	TlwSjQV3sxht3AwCDgmxdqYM8naNuTXugV/MQsxtAzBzV/gnsDJNAYTSENSw3Mvpq0izl99OWNm
	HTJU+3JMhH5+4ICND353buSkjkEcMbHATcQdFiYeQL/JVHzk5YjhjENQ4TyY7fSIDbe759W2Ci8
	is536Ht
X-Received: by 2002:ad4:5dc2:0:b0:896:f8dc:f6d4 with SMTP id 6a1803df08f44-899d1d6ca54mr69417576d6.5.1772238489925;
        Fri, 27 Feb 2026 16:28:09 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-899c7376847sm55825926d6.28.2026.02.27.16.28.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 16:28:09 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vw8Bk-00000001WwN-1wgX;
	Fri, 27 Feb 2026 20:28:08 -0400
Date: Fri, 27 Feb 2026 20:28:08 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: dan.j.williams@intel.com
Cc: Robin Murphy <robin.murphy@arm.com>, Alexey Kardashevskiy <aik@amd.com>,
	x86@kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	linux-pci@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Mike Rapoport <rppt@kernel.org>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>,
	Ashish Kalra <ashish.kalra@amd.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Melody Wang <huibo.wang@amd.com>,
	Seongman Lee <augustus92@kaist.ac.kr>,
	Joerg Roedel <joerg.roedel@amd.com>,
	Nikunj A Dadhania <nikunj@amd.com>,
	Michael Roth <michael.roth@amd.com>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Andi Kleen <ak@linux.intel.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Tony Luck <tony.luck@intel.com>,
	David Woodhouse <dwmw@amazon.co.uk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Denis Efremov <efremov@linux.com>,
	Geliang Tang <geliang@kernel.org>,
	Piotr Gregor <piotrgregor@rsyncme.org>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Alex Williamson <alex@shazbot.org>, Arnd Bergmann <arnd@arndb.de>,
	Jesse Barnes <jbarnes@virtuousgeek.org>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>,
	Yinghai Lu <yinghai@kernel.org>,
	Kevin Brodsky <kevin.brodsky@arm.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	"Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Kim Phillips <kim.phillips@amd.com>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Claire Chang <tientzu@chromium.org>, linux-coco@lists.linux.dev,
	iommu@lists.linux.dev
Subject: Re: [PATCH kernel 4/9] dma/swiotlb: Stop forcing SWIOTLB for TDISP
 devices
Message-ID: <20260228002808.GO44359@ziepe.ca>
References: <20260225053806.3311234-1-aik@amd.com>
 <20260225053806.3311234-5-aik@amd.com>
 <699f238873ae7_1cc5100b6@dwillia2-mobl4.notmuch>
 <04b06a53-769c-44f1-a157-34591b9f8439@arm.com>
 <699f621daab02_2f4a1008f@dwillia2-mobl4.notmuch>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <699f621daab02_2f4a1008f@dwillia2-mobl4.notmuch>

On Wed, Feb 25, 2026 at 12:57:01PM -0800, dan.j.williams@intel.com wrote:
> > (since a device that's trusted to access private memory
> > isn't necessarily prohibited from still also accessing shared memory as
> > well), hmmm...
> 
> The specification allows it, but Linux DMA mapping core is not yet ready
> for it. So the expectation to start is that the device loses access to
> its original shared IOMMU mappings when converted to private operation.

Yes, the underlying translation changes, but no, it doesn't loose DMA
access to any shared pages, it just goes through the T=1 IOMMU now.

The T=1 IOMMU will still have them mapped on all three platforms
AFAIK. On TDX/CCA the CPU and IOMMU S2 tables are identical, so of
course the shared pages are mapped. On AMD there is only one IOMMU so
the page must also be mapped or non-TDISP is broken.

When this TDISP awareness is put in the DMA API it needs to be done in
a way that allows DMA_ATTR_CC_DECRYPTED to keep working for TDISP
devices.

This is important because we are expecting these sorts of things to
work as part of integrating non-TDISP RDMA devices into CC guests. We
can't loose access to the shared pages that are shared with the
non-TDISP devices...

> So on ARM where shared addresses are high, it is future work to figure
> out how an accepted device might also access shared mappings outside the
> device's dma_mask.

ARM has a "solution" right now. The location of the high bit is
controlled by the VMM and the VMM cannot create a CC VM where the IPA
space exceeds the dma_mask of any assigned device.

Thus the VMM must limit the total available DRAM to fit within the HW
restrictions.

Hopefully TDX can do the same.

Jason
