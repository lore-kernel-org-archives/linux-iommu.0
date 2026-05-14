Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 087C04219F9
	for <iommu@lists.linux.dev>; Thu, 14 May 2026 15:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778773447; cv=none; b=iSWY1uvOzOg5RkxgHr+qT7X6oy5xf22wcsG1Pd9Gc6YWcqJDCMMc7qRnC7tCc1NZbDO5Anv/OO5nrJz8xnm3mqVS7i6jHvFARjBJHeAMHj5sHA3kvxtHV2ZVXCdpeQctcC8Y56xUUadrxM7Id6iVVwM7XNgYPREPhtH1WdrGf24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778773447; c=relaxed/simple;
	bh=RPg0i4XM92mQzsrFW8OMk2e1DfkKszLgHmEy1kgrd5g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WARa//j3YpSVJG/bNem5AjwSpXgYk14t8xj5sEBst5KbZtjFDjsLukmjqPxmr9Qj9VeiucEZ35A0E4OKzkbwbhK7CvQL0jnOSq16Ylip0K2MoDjjF0u9IIhDIltcECrETm/xv0wHCio+fM4GjNSjtXjut5TXqF408xrpuNPUNBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MvvaN1BD; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MvvaN1BD"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4891b4934ffso120355e9.0
        for <iommu@lists.linux.dev>; Thu, 14 May 2026 08:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778773444; x=1779378244; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lh6aFT9PQ6X1PkDdo12UH9E/whRlrKT0Rk5qkvPCSq8=;
        b=MvvaN1BDry7eeApF7bwILe1kOBxDHsYasbyWOk8fXgTmUNRU3A+c6zlhDWIHRyk03X
         IN2hWxltuwI/RAhhYdH9UKVaIeF/RsuDcKqe3XqLKYQ9MgA+MAKMQunpHaR/hFN4ZfYT
         p9VaYLZ9WE5WpAx895Qibez6V3ekBEz7vpaQiamMPNmdmyo2+dKKYaOEPdfEVDdLKmv7
         dY8KoZJdOoH60Sjqh7dtjluFazTA0wXmHs7P/vjgjPs5pUCOPg1QE2ZL2pQB+CzokRxx
         a6uQxTYuJv9P7AKIYqChwAvgf8djDYC2WkxzJ4vcKORbj13zciMT6MwVnbeluiogFGdR
         21uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778773444; x=1779378244;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lh6aFT9PQ6X1PkDdo12UH9E/whRlrKT0Rk5qkvPCSq8=;
        b=GEQgQBhZzLMas6efa1X1YYMlM6N/tJMrYLPMCvmWim2TMi6C3HhMGg+9jhFxOaTyoE
         DEEyp2gY5vFMpJJy4z5/3W4WvEsWvtU0DNrrdqHMn4JygtymDy9nfnG4lYbIxM6mRyLt
         KcUTowH9c2LUNoB4DFNS/gnZ1VcnFdizqgtKGXUVtD33nhP1BOtXkG/sza+MuO6RZtij
         c++Szo+UzyJDjAO1S4O2Eup56scOwK/azFE355izdK7vNa2y3Xcw96UB4hcl1YEUivrB
         8V2ITyu6hNXyr6vF7qjNKZnQRX/qQQxgpSnNDP6+E27CsGq8poSMPBtFNcrCOr4CvqGn
         Rqtg==
X-Forwarded-Encrypted: i=1; AFNElJ9T1U9Jai9MGe0cUh69n+1+FC+HTVHo+l6G2LZNsk0nEHkuTdxhwWldhATGkczmpDAvIj55MA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxrrdCQoXGdlXTpbpmnM3JE4sgjiQuTwhLw73CyJwa+rSya8/8K
	PSpFFEgzyu/c2e9LvfDXCnqYU5hJvVBwQb+CFjSdOLYdsiGwQ4jkhgnWATqMeiHaZg==
X-Gm-Gg: Acq92OFdwWQr0nsPv5sWMcvayPzx3VBwfZ1NNdd3eGQKktYfTa7PD3U0hInpktwoc/H
	Ly/zRvWfycFBCEAnKmoLRkCZ6mapxceuK+PP4fmDXufnddlfi7t+2gJr9dqRgmRMQvScoeRfd7r
	WAei5duy6olQGmROsWwTcGTWBdlLaXZ0EskiweXyI4slZNjqofIHNzvjv0FX2c9BFCCaTpStpEb
	KdHb1QgLqFRw9LHIAHay+o1QabYzq7v72LkP0UqnPH1ozLEnza3xMCuUAgkQM67Jt/g1mnPEGcY
	CZRNfJXU2aZMjQIdr42bcBl1Nb/YxK8K6ECH16KSL4NajxLCVPJdLZv9h/ZKa3siKiQW/cOxJpf
	5H+ABewD+fOSvP4Iq7jcLcZc+8XrUuWVT9ZEzB+eCnEzYGEdG42HpZbjhx21d5vW4WqeoJVsbkd
	5KpbDfrYfCFBhklh+KIbc8zOtPE5+4pZBjFQzmFLJMf+JOcXoaq77bDikdGMgruvaGHlk=
X-Received: by 2002:a05:600c:c04b:10b0:48a:5d95:d33e with SMTP id 5b1f17b1804b1-48fd6e10247mr915845e9.6.1778773444106;
        Thu, 14 May 2026 08:44:04 -0700 (PDT)
Received: from google.com (8.181.38.34.bc.googleusercontent.com. [34.38.181.8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45da0fe0f72sm7842670f8f.25.2026.05.14.08.44.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 08:44:03 -0700 (PDT)
Date: Thu, 14 May 2026 15:43:59 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
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
Message-ID: <agXtv-Wsun82SRmf@google.com>
References: <20260512090408.794195-1-aneesh.kumar@kernel.org>
 <20260512090408.794195-5-aneesh.kumar@kernel.org>
 <agSKQrSIhizCXKwx@google.com>
 <yq5ah5oaa63h.fsf@kernel.org>
 <agW5rhE9n2gDQ0w5@google.com>
 <yq5apl2y5f96.fsf@kernel.org>
 <20260514143733.GB7702@ziepe.ca>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260514143733.GB7702@ziepe.ca>

On Thu, May 14, 2026 at 11:37:33AM -0300, Jason Gunthorpe wrote:
> On Thu, May 14, 2026 at 06:18:05PM +0530, Aneesh Kumar K.V wrote:
> > > There is no problem with non-protected guests as they don't use memory
> > > encryption, my initial thought was that th encrpyted/decrypted is
> > > per-pool property which is decided by FW (device-tree).
> > 
> > What I meant was that we need a generic way to identify a pKVM guest, so
> > that we can use it in the conditional above.
> 
> If I understood Mostafa's remarks I think different devices in the
> guest need shared/decrypted and some don't? Ie a virtio hypervisor
> device needs shared while a real PCI device doesn't? Is that right?

In upstream, device passthrough is not supported, but that case is
supported in Android and we plan to upstream it (it currently
depends on the SMMUv3 series first)

> 
> In CC terms that would be a mixture of T=0 and T=1 devices hardwired
> and signaled by firwmare..
> 
> Ideally we'd have a flow where if the arch precreates a swiotlb pool
> with special parameters this overrides all other decision making. Then
> this series is about making CC NOT use that flow... ??

Yes, I believe that will be needed, we do this at android by a per-pool
property added in the device tree.

Thanks,
Mostafa

> 
> Jason
