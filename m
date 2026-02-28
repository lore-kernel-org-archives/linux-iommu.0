Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A95483C07A
	for <iommu@lists.linux.dev>; Sat, 28 Feb 2026 00:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772237194; cv=none; b=TdIRD2WDdq3LfJ3HfaWe4HI+dFle8DT+3fTyvCcncGLi7Dz9LxNXwQbWIiJRQcnytUwy6VT34Zdk7t8w10w/8loNbURNYPsFdCyjd24jK6VOi5Kp+9popobmXd6d5Buo+m5S9w1q+uG0Mo1dQhcRqGkukffQnIp+HlXbp2lZlX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772237194; c=relaxed/simple;
	bh=D9pygYo/MNi4R02Zm4iGOoF0L2rPsDKjb9gvCd6vgKs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uLxxDQX/0EBoxf3LuRpWyGNbIgS8isTmHfRNnj1C0xFlNOrl8W4U13Hq83CptTa+ho85jESBAM5p1wuduwzPxQVmk+ENFEGzX51c1pZ//4XOHPgqFUuNPI+pVe8pd3941/67YVyVPMCd3rykrZsifKfNpNykHfUvHdHEW38YGII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=juAMHeZh; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="juAMHeZh"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-8cbc593a67aso200587785a.2
        for <iommu@lists.linux.dev>; Fri, 27 Feb 2026 16:06:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1772237192; x=1772841992; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=S0PqAr3dacsxbzSna3ChPqWEVOFqnIEsALZmA66GjLs=;
        b=juAMHeZhVrFgsl1sAkwTkIZepgLQSrYd8Vtvh2kyGwiYs5oc025H1C58Zu4FjRBCij
         i5uO7y6UTRwYx43AKt4hqSkUTRxcOy11yboG4AKYwy1UoRpcvaGALmc/rUZUu+bb4ZiR
         p6rJTbSfq6HQn4Ixytx1iNuDQ6GPQsej8bzzEhXS7kacN8ufAscD3YjpjYXyNYfAsRty
         GU/4ZurfzdED/aHjMvwaIHLSsKoEIlsh4UWKtA/oWsYK3UV/ZVgBJGpsgy7zvLxB49Ur
         BWYoBINlvvHw7o9MynoS+JeWQmMlbw/Yum/nYmEtzioMHMTRgCOpgwtGO71VagDdzphf
         A2IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772237192; x=1772841992;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S0PqAr3dacsxbzSna3ChPqWEVOFqnIEsALZmA66GjLs=;
        b=q+ihs9GDFvOA+BphuSauzHuyY/ySV4XLyoZDYxtlwpvyRAS4u3OHv9DXbiunkogEsX
         2Sv3kYKyv0w+NmtKPpwaWXE783nckHKXNGDcj4vwYWFRqi3zznZKIe4nXzrjpumsDJ/0
         yU7f5uL5ECwaTGe3JVh4m014ZLlnky5ByfMqgvdYSW6Pe+xiPyXzZJT26K8GcCausnOO
         EmBIDTV0AbyJedqO6W39mFNXKtQTUKNN0j/R6w/Ljfbw3J22rGLzKslyP+SBOV/2ilM1
         WooNwq6tz54bhv0dVD6xu+EaaUY6Vpkx6ApdLcy46YX2akUIKGuqYI7oFVY/MdU1lMeb
         o4aQ==
X-Forwarded-Encrypted: i=1; AJvYcCUNWxQnTa6MqXEgo7CRsQDPGDAGfyDiDeKGde60b1i3u70imaKGbgIcBbKQOTBjH7OkO7kkhQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzS1xL1YLnGaQuw5zKFjJgt/5+hnrDj1H18Geo1Cf+0hk5FNWhN
	X3gRb/btNzdURnnnWjeVcH2HjTd0rWy48pGQh8XPmN74zByE7H6AZYHcM4jg3mzxda8=
X-Gm-Gg: ATEYQzyc8HgkgChSy1jjp3zTrlqF/Ss04eXmKOLhSBL6NztikxG3v0Q3Y3vty65sxTW
	dtSTmzq6m3XozNwk+Enmznp+CmlhkSxkz7J6IQ1xEKJ9sdHiTFuF6XAuAkzUslBon+qzmv10OY8
	YzASwTtklkbY6d0DxjtSNaHuwRJPoI/E4froh9oxI0R+qNZAQdcnlQn4xJqpG9UhSB0gPgbniSL
	rI6lf7blvA0A4hhaGbTlxgpriXDULloB7iHuCQF+Lp0l4lgQCIXjBk1I4VFKyW3GORj08eII3Zp
	58WnllaU2O7Br0r8T7799xYMqrfN5NCKdCfixVtdkoYsiy2TyMHyPmX2rChwSlncd0qyBSaXLwK
	drV0aRWq4vcrCcT4D0pE+gUc5yH1NMVNuBIzXI1z413rgghpWjYp1gKpq839KSca7enUjoH2LcY
	985W30KK2NmYs9bONLB0Hob/sO8sugqeLr8WxIqen7ZDYvXP+MWQ1BH94kQXDIu9RBSDUw2Uiss
	mOgq8U2
X-Received: by 2002:a05:620a:1a92:b0:8c7:b0d:df23 with SMTP id af79cd13be357-8cbc8e39692mr613986085a.79.1772237191471;
        Fri, 27 Feb 2026 16:06:31 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cbbf72d3casm601180485a.42.2026.02.27.16.06.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 16:06:30 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vw7qo-00000001WqD-1LkU;
	Fri, 27 Feb 2026 20:06:30 -0400
Date: Fri, 27 Feb 2026 20:06:30 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Alexey Kardashevskiy <aik@amd.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	linux-pci@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Dan Williams <dan.j.williams@intel.com>,
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
	iommu@lists.linux.dev, Jiri Pirko <jiri@resnulli.us>
Subject: Re: [PATCH kernel 6/9] x86/dma-direct: Stop changing encrypted page
 state for TDISP devices
Message-ID: <20260228000630.GN44359@ziepe.ca>
References: <20260225053806.3311234-1-aik@amd.com>
 <20260225053806.3311234-7-aik@amd.com>
 <d8102507-e537-4e7c-8137-082a43fd270d@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d8102507-e537-4e7c-8137-082a43fd270d@arm.com>

On Wed, Feb 25, 2026 at 05:08:37PM +0000, Robin Murphy wrote:

> I guess this comes back to the point I just raised on the previous patch -
> the current assumption is that devices cannot access private memory at all,
> and thus phys_to_dma() is implicitly only dealing with the mechanics of how
> the given device accesses shared memory. Once that no longer holds, I don't
> see how we can find the right answer without also consulting the relevant
> state of paddr itself, and that really *should* be able to be commonly
> abstracted across CoCo environments. 

Definately, I think building on this is a good place to start

https://lore.kernel.org/all/20260223095136.225277-2-jiri@resnulli.us/

Probably this series needs to take DMA_ATTR_CC_DECRYPTED and push it
down into the phys_to_dma() and make the swiotlb shared allocation
code force set it.

But what value is stored in the phys_addr_t for shared pages on the
three arches? Does ARM and Intel set the high GPA/IPA bit in the
phys_addr or do they set it through the pgprot? What does AMD do?

ie can we test a bit in the phys_addr_t to reliably determine if it is
shared or private?

> > pci_device_add() enforces the FFFF_FFFF coherent DMA mask so
> > dma_alloc_coherent() fails when SME=on, this is how I ended up fixing
> > phys_to_dma() and not quite sure it is the right fix.

Does AMD have the shared/private GPA split like ARM and Intel do? Ie
shared is always at a high GPA? What is the SME mask?

Jason
