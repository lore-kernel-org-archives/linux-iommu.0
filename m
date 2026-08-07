Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E792377EA1
	for <iommu@lists.linux.dev>; Fri,  7 Aug 2026 18:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786126441; cv=none; b=bQlXCEG5q3RYR6+0DSzLnteyLUq9xai1Nzv5cpPa2mgTfCQ5xuNc1S4SvuU0tNo8TGos/CtHrgYk5UanVcwdK6ciLtA0PJ5NxUy6Z4JDVK6Bh/aMmJIpr0MlO/G0qwcBBtr4rwgNXJC3SOva0fTUAgLXBYljQh9KuflAs/WRUjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786126441; c=relaxed/simple;
	bh=E7Ex4RBUa7IG4kdLmTYk7y3iUle3Rq8qAnZNO/0MU2c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ayk2/+rHNRDxWxQ6K60rrBawdFzxF3dvsk1x9iIrfKvIFUdvAD9DQU/1FE/tdPenrOC/+tRAIRMAYskkX8YzOGq/wgByKrrghWqjTh69CfVnma8rTDHUQmg3fhej3fb2405WcSKGUpRH0t75+eG6XIuZB+N5LvNUk5FnHr35ulc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=d4buJpdK; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="d4buJpdK"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6a177b2dc8dso1031a12.0
        for <iommu@lists.linux.dev>; Fri, 07 Aug 2026 11:14:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786126438; x=1786731238; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NlmgqKiyqc7mU7pAn/JSXJE8TLhKwTlI/zLMMe65kC4=;
        b=d4buJpdKSIaZJy71IfzT8H/zKheMrtFC9C49c7wYwKeC3w0OFT1prUHFH7un5YwL0t
         zCIg/J/AjEA3JPBNSOOWeR/0cdnK0D4HSSSXZ55V6P98MnlvyzX8EKe9mjCDo0+6eFo/
         6tG/WzJWs6tp5nQaXfl0GNAZoPXqMe0wSQJdCt7Uba+/jgSHtTgmGogijx4iSX1GKbAH
         FurQkuXdES3oHGlRNV5D29VbqQsrEPpSb3PFCf58+dIXa+8KkA464lUR4eVYOFbykm7y
         Hz7aMXUZ1sT0HNAJGQ4CTIyRb5ahJMZ3FYAZ9pKBEr8WG3bZo+lSyuZnDPR52lbKmudt
         E47Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786126438; x=1786731238;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NlmgqKiyqc7mU7pAn/JSXJE8TLhKwTlI/zLMMe65kC4=;
        b=DH3rVh8tVNn+uIkwHjt4Ama74kPzJ52OznyIzhTstpkijSK8j3fjzeyu4KcP8MQbRm
         Xp7y+4iss75TUY1n28aOcr6Dw2SbI8w0IhPFSQ28klRUbRI2EDi4XfvfC75YeXmLqOnO
         0irX9ZcilPm+zQrVuofzxwpu593EX2Xu+OYH6Bk2VzOWN2lF1oHqa44cRVumSni4/gEH
         oxKIlA/VSKcgcz5FcsGSl2Xa3voxq7cXVMd5jZqwy8WE4X3rQvZjvDw2iwhnS2uy39Ep
         IlaSKN7edb+3/JK7Ban2nT+FkO55aM7ck4t0kXxOd82PI0G+SiWjDq9JekdCIVQPLVko
         i2zQ==
X-Forwarded-Encrypted: i=1; AHgh+RrCKf+qaUHkWMpJz7H9y/Eb+OpuuPGZ5jVi18bKkPeGmfTmYkNySdQQ361arBRFqfzXzf2jKw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzUIVOv3R1v+zmVZFrwiGWziT4lriebqiXawfwxKlvW5+j8zNJ9
	tbknJitudTIZ0cDSlSZ9J8BoMivSkCLkxY50jvKuzCVba1iF++VwgwAcCX2KOOn9Fw==
X-Gm-Gg: AR+sD12dAgIC2EW15f64yXtGTlCNHDEeALwBHBfLP8M1x5b1KKbAztVzE9AKy3889C2
	WhCFdHPrNq6dRq9HVFxS21E+7ZaIzaTH8KsWcoQcsMMk9Um7GSN48i8ogMrwFhUzES6qbINOAOj
	1+C7q0Hf0jLjbioZr2xd81SwX0GTicyPapmrD9lxMGDP7sxp2IhFtFlujq5qG2yBS+4qh5cO/O/
	W0nz/+xZZkICQPuXyp9fccIPiFHm2jno5IWC5o0gt4In/DWBrQp9J/8mKi/VVnlpXuD9FS72r3j
	wtSw+Ts9eTsmQ4zzNnQsuZ4eq855anZrLUuBwg4SprnwHPz8KRvX5PcsA2/J+0miPmkCMLpAs9V
	AWvvQC2dA/qFT5M5SB5vnH1+/Jvco9k8hYD1pkD6iD+oy5sNqGSvXCkgOeoSbY0A4JNgn2N4c2u
	4fl08sqVvM+b0eJFRtJm6h4MCOaWQeAZAiSDjvtYPRuVkg9C5IMNEXAkDD6MhusDHwkKHRwOVij
	V6bM8yut4dNg/3ScTMzEBhHR0ki1g==
X-Received: by 2002:aa7:ce06:0:b0:6a1:f26c:ae2d with SMTP id 4fb4d7f45d1cf-6a1f4f438f9mr5439a12.6.1786126433777;
        Fri, 07 Aug 2026 11:13:53 -0700 (PDT)
Received: from google.com (250.192.189.35.bc.googleusercontent.com. [35.189.192.250])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2080ab446bsm79186966b.27.2026.08.07.11.13.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 11:13:52 -0700 (PDT)
Date: Fri, 7 Aug 2026 18:13:49 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Will Deacon <will@kernel.org>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-coco@lists.linux.dev, Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Marc Zyngier <maz@kernel.org>, Steven Price <steven.price@arm.com>,
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
	Christophe Leroy <chleroy@kernel.org>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>, x86@kernel.org
Subject: Re: [PATCH] arm64: swiotlb: Keep the default size for protected
 guests
Message-ID: <anYgXSR4VAi3TpOj@google.com>
References: <20260717180442.110954-18-aneesh.kumar@kernel.org>
 <20260807092612.2202005-1-aneesh.kumar@kernel.org>
 <anXIZSh9lq99VG9X@willie-the-truck>
 <yq5acxvu2ict.fsf@kernel.org>
 <anXbJ2O4DWgPxCeg@willie-the-truck>
 <20260807135810.GA200537@ziepe.ca>
 <anX7F7dnKOtAOIIe@google.com>
 <20260807164734.GE200537@ziepe.ca>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260807164734.GE200537@ziepe.ca>

On Fri, Aug 07, 2026 at 01:47:34PM -0300, Jason Gunthorpe wrote:
> On Fri, Aug 07, 2026 at 03:34:47PM +0000, Mostafa Saleh wrote:
> > On Fri, Aug 07, 2026 at 10:58:10AM -0300, Jason Gunthorpe wrote:
> > > On Fri, Aug 07, 2026 at 02:18:31PM +0100, Will Deacon wrote:
> > > 
> > > > > I was under the impression that there is a possibility of using swiotlb
> > > > > instead of restricted-dma-pool with pKVM.
> > > > 
> > > > Yes, that patch enables swiotlb as a possibility for protected guests
> > > > but with your patch we avoid shrinking the swiotlb buffer even when
> > > > restricted dma pools are being used and that's a waste of memory.
> > > 
> > > I also thought we switched pkvm to use CC-like swiotlb as part of the
> > > alignment in this rework? Mostafa ?
> > 
> > Yes, now protected VMs can use the SWIOTLB for bouncing. However for
> > Android (and kvmtool), use restricted DMA. so SWIOTLB is not used.
> 
> Oh? Why?
> 

The patches are not in Linux yet, when it eventually lands in Android
it should be possible, I did some initial assessment and did not
see any regressions.

> > However, I do not think we should over engineer this in the code,
> > swiotlb can be set from the cmdline and now through Kconfig also.
> 
> That's fine for android, but real users buying a cloud VM and sticking
> a distro on it shouldn't be expected to have to mess with cmdline just
> go get a halfway working system

But the whole thing is best effort anyway, the kernel picks
IO_TLB_DEFAULT_SIZE which does not depend on the system topology or
how many devices or how much DMA they do.
SWIOTLB memory is wasted if unused so we should be careful around
that as it would be the other way around and users would have to
decrease it manually.

Thanks,
Mostafa

> 
> Jason
