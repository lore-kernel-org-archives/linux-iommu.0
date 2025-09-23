Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37CBB264A65
	for <iommu@lists.linux.dev>; Tue, 23 Sep 2025 15:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758642660; cv=none; b=d6cuep22aL9tSmTlim0ssAAxEg2KnpCmulw4lQM4MkbJfe7T+/iB2ShYT7P6Fhmcv8iOa3M6xH8aeUpfmJ+zN+CwUKYLMM2tPOpqQ+Z3Om9KAySo99LzMYwFuoEwlaKDfi4RDKUSp6QlHqwzYeCvKk0zyn3Ctwy+3EzUI0ykirw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758642660; c=relaxed/simple;
	bh=y4VwCCCCWo6KKwueZ28Bgn8vy5ceg5kGAxCvv+C/JDo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mvyMrgAZnoJQWEJV3HT8uB9+oObuBnGna8PpgwZ6YxHxEDgeYNro5iUDkXciRyK0yBZvqDtz3t3oFpXZgvSRIm3t4psxgUSmd+HFny6+MLL3DWc8W37Ctl37NYota8AwCl5niH8OD8OtZ/3Mkp5o6dJ40+VtEUkB+udhvcNHhX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=lx1jHfeO; arc=none smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="lx1jHfeO"
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-635fde9cd06so908822d50.0
        for <iommu@lists.linux.dev>; Tue, 23 Sep 2025 08:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1758642658; x=1759247458; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3CqX8wo4OIF9dVnHcV+vNQ/UyqzH0cRogmJfYlIiKHQ=;
        b=lx1jHfeO5A6wjsjdB+KtDe6m/m8s+3c4GdNF+gW81SV0JEN4hYi7M8hSlJY1X4LU2T
         w3X74lzpvcSKJUibHdwnndSfs5E4io5l5TweFjIJ+79T1qI618C4JvRossxPOcKrRgbN
         UNcV45BfrdyZz9SXSLrYHRhOj65UIkNSc7KqReDSii35mlhWDh3JJyweo2/i2b67U7Yf
         Q7BahHf6VGj5eiaQVha4fqcP3O7wDObDF4BYr/ie5+qee1BbQYB7rpmJyceuUq0yaiCq
         2kPH7UPsJ67MQ6pwZduwRnyKKCGBeEhUPGQX49FPl+jsZAH1LWdESDk8xCZNbNSBJ6KP
         Bepg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758642658; x=1759247458;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3CqX8wo4OIF9dVnHcV+vNQ/UyqzH0cRogmJfYlIiKHQ=;
        b=B/45zWo3H7g9ZTYZ2zuAzJ44O0pg9/KJkLNzjz4C+yoLNZCZbCckjPlDCR2UxAc2Gn
         fmqo9JvWxYnOLUBZKzVbPr2S/vdUQIz6BTVaVOHQM/LGtXCS5+9T6W7YvtLhwTFA21lH
         IKq8fpXXwhWxbiFyhL99jMpSRqPQs6junZ+HPN5KNdlY9ixNY/4Kus4XakGsNx6pz6e5
         owiCM84mFagSQ/aPW0j61/87tAiWCUepw2ldYMnJgyLU8FUp/2wUrEark2+22OtpF7up
         8kDzEO25tFsuLzeCcy5wpJOA4QPNURvUK4CN5/itTuxd8uqMfCMgzcOJzBpp2+dK+xkE
         yd+Q==
X-Forwarded-Encrypted: i=1; AJvYcCUXTq/5K6wNze1e3bEoD1o4AmeuFaNuOQQN3+zHROU1WCYD1C5S71BX8/vXNircjbJi4tbUvQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwcxsnqOUAvlpXl420Jmiz5136/jGQA2sgyrXdbykHKQB45eFKe
	5TTjhvnpNLXX4/DTxYvMsJ2ZK0nrfss72gXWZBb+rANhScz5ykzmHaxmL/BEj75XEgo=
X-Gm-Gg: ASbGncvU+K9escMFbdTaMKJ3NBdvNWk1YqLZFMOPi8ysjKRoY1CTfyLoBx3i7EZCZmn
	HO/rGa8MuTRTRtefr81E+RkzaRduJW4v0mxE3kCgkVkAV2x4to4L81I9YsUlRBHo8uW8g00WhLF
	F314AighlezsqUAf2isG5BYARtFh8mOpNgpSItNRF/jM9wpxEXXKUFE8R7DzWZL2s9jgQWGFMS1
	dWzh1glib8x2g8ef8hHYYX1VQcL+Hnemw0OnmTELDyrEOT0GxzlJ9opGFjUGoCdg6T54CPTjTGz
	PX06l6P5Wbgez72j3Q6Xt5GOVa65LaA6TbBkmZGJXkeRPwui7TlhyCtUG31Gt/GXqKXA7G++Fri
	1ACJESHOVTdECFWJ8Kx6T109E
X-Google-Smtp-Source: AGHT+IG9zvGVFr+YOmFk29/0ncfJA3SG76AOSrmrzmJdcjBUK8KbuId/KM4G7ZMmRoUwWwnCaf4a6g==
X-Received: by 2002:a53:83ce:0:b0:636:3cc:28b2 with SMTP id 956f58d0204a3-6360476fce8mr1873137d50.36.1758642658091;
        Tue, 23 Sep 2025 08:50:58 -0700 (PDT)
Received: from localhost ([140.82.166.162])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-633bcb601d6sm5411190d50.0.2025.09.23.08.50.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 08:50:57 -0700 (PDT)
Date: Tue, 23 Sep 2025 10:50:56 -0500
From: Andrew Jones <ajones@ventanamicro.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, iommu@lists.linux.dev, 
	kvm-riscv@lists.infradead.org, kvm@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, zong.li@sifive.com, tjeznach@rivosinc.com, joro@8bytes.org, 
	will@kernel.org, robin.murphy@arm.com, anup@brainfault.org, atish.patra@linux.dev, 
	alex.williamson@redhat.com, paul.walmsley@sifive.com, palmer@dabbelt.com, alex@ghiti.fr
Subject: Re: [RFC PATCH v2 08/18] iommu/riscv: Use MSI table to enable IMSIC
 access
Message-ID: <20250923-e459316700c55d661c060b08@orel>
References: <20250920203851.2205115-20-ajones@ventanamicro.com>
 <20250920203851.2205115-28-ajones@ventanamicro.com>
 <20250922184336.GD1391379@nvidia.com>
 <20250922-50372a07397db3155fec49c9@orel>
 <20250922235651.GG1391379@nvidia.com>
 <87ecrx4guz.ffs@tglx>
 <20250923140646.GM1391379@nvidia.com>
 <20250923-b85e3309c54eaff1cdfddcf9@orel>
 <20250923152702.GB2608121@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250923152702.GB2608121@nvidia.com>

On Tue, Sep 23, 2025 at 12:27:02PM -0300, Jason Gunthorpe wrote:
> On Tue, Sep 23, 2025 at 10:12:42AM -0500, Andrew Jones wrote:
> > be able to reach be reachable by managing the IOMMU MSI table. This gives
> > us some level of isolation, but there is still the possibility a device
> > may raise an interrupt it should not be able to when its irqs are affined
> > to the same CPU as another device's
> 
> Yes, exactly, this is the problem with basic VFIO support as there is
> no general idea of a virtualization context..
> 
> > and the malicious/broken device uses the wrong MSI data.
> 
> And to be clear it is not a malicious/broken device at issue here. In
> PCI MSI is simple a DMA to a magic address. *ANY* device can be
> commanded by system software to generate *ANY* address/data on PCIe.
> 
> So any VFIO user can effectively generate any MSI it wants. It isn't a
> matter of device brokeness.
> 
> > near isolated enough. However, for the virt case, Addr is set to guest
> > interrupt files (something like virtual IMSICs) which means there will be
> > no other host device or other guest device irqs sharing those Addrs.
> > Interrupts for devices assigned to guests are truly isolated (not within
> > the guest, but we need nested support to fully isolate within the guest
> > anyway).
> 
> At least this is something, and I do think this is enough security to
> be a useful solution. However, Linux has no existing support for the
> idea of a VFIO device that only has access to "guest" interrupt HW.
> 
> Presumably this is direct injection only now?

Yup

> 
> I'm not even sure I could give you a sketch what that would look like,
> it involves co-operation between so many orthogonal layers it is hard
> to imagine :\
> 
> kvm provides the virt context, iommufd controls the MSI aperture, irq
> remapping controls the remap table, vfio sets interrupts..
> 
> VFIO needs to say 'irq layer only establish an interrupt on this KVM'
> as some enforced mode ?
>

Yes, this is the part that I'd like to lean on you for, since I understand
we want to avoid too much KVM/virt special casing for VFIO/IOMMUFD. I was
thinking that if I bit the bullet and implemented nested support than when
nesting was selected it would be apparent we're in virt context. However,
I was hoping to pull together a solution that works with current QEMU and
VFIO too.

Thanks,
drew
