Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15F991E89C
	for <iommu@lists.linux.dev>; Tue, 23 Sep 2025 16:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758645227; cv=none; b=b56i3OkP3SYZvmeN05n7HwdrV3AZLAFRu5/ga2dgOubjI/ms26dYdpsyXxNKchg4pyja/LouCMUqgJRPUw4KOq9irG5ABCbU8NnGDP3WwNPv+4w4DY94B4OH+p2H/xL0IZrIkU4+K4Xy92KAE07mcEqaC6+9uwEmzx1I33h9RKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758645227; c=relaxed/simple;
	bh=c9lJuD7XPdx2TT3KIsiYo2tcOfkrfaX22l4ExJCJ1bA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gZh8/4HGvvzKBBvQYrXpCyAKDoYHdIGvyRRVocmFFwYAHlbRjKaKnR31F0D65yrXdH/LnXtXsPEM6loJGYQqsTI2UPbpIzhKeaaD+OM2jlZYQr48sb8dZ75k5jWjDOV9gr8wnTarOiGx5xJHR21n4cEEjLsKKP18v3UKBi7EiEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=o9vdFrhy; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="o9vdFrhy"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-71d71bcab6fso55821737b3.0
        for <iommu@lists.linux.dev>; Tue, 23 Sep 2025 09:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1758645225; x=1759250025; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HuFofpSTnN4OjG4be97xyIzqOCkiDml5pbTJvbN5Wpk=;
        b=o9vdFrhymluGWm81as/Utpm9uZQdjko5wDdsy3RNRAgeHbqdbh5npe87ZEOwbKcfkS
         D2FyTTz/z/+7B5Wj4jlx2J0OKzDILf6loEl3izIEDWJzNhG4dlEZKW+cGbfA9tgEWMyZ
         sMb3eVQqOedBl3GLAuJNmSaWcauKQOB5kaJhSeAEh5eGRCc3QsDqtJL4wYOtLzZJQ28L
         Z5vkBIur6bpZxpzA6eEIbIxUCfXqwLHexLTfC8NjIXQeHj2ae/iczVbjPT+zgi/1g8AO
         if4jYog15IdXGSgMyJHoqDXE9Qy0rvsBoiiNUr2F3xy1E9hF/+uvM1iUp7lCtpaAijeA
         sOrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758645225; x=1759250025;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HuFofpSTnN4OjG4be97xyIzqOCkiDml5pbTJvbN5Wpk=;
        b=h/hZAqybwbVHeNs1U9zZtiCpqzmL42c+Q0ISXRg8gdS8oNtqkG/5zv87LnZ0HwoTv4
         XtExsdNEt/5KF0NsXH9Ak9dArA+CRJqNTPBA9XUDipFI+tyE4c8y4S7M4feFAB0H6epF
         WjHlzVw0fZWRH6WjIemeecD/fVqT0v3rL7EjWLdbytYhp+Kw1hs0tZn+FUYGTaBQg4pl
         zTCCH36FpV0x6yxf5Zi6KtYb9+IOPc6Iz3K3hawYkIT0SI7fkaQXXy8txxIXRrHhAVPw
         yh754Hmmplz04Zs6+6jBOrepFLC9jyNAAjoh1ixhWjgAIKSlfvfD00ddXdBVfLeDvVsg
         XZsA==
X-Forwarded-Encrypted: i=1; AJvYcCWVgNHJWplQRZ575MzuKbtG8H+lIv9FNCMBKNCZBvozUSZbTp9+KAERDHCy3zoytvo63TjOGQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxMQbYIUEUOJYy7eW31MrFXR0nLYyOO3tvpw5Et7jwX//TVxQCy
	fsOZwVq22ZZ/obTOClfVZs9B9L4YwyA+beBh0mLLD4q0mW8yUNVb8VNiRd9Rzy838Ko=
X-Gm-Gg: ASbGnctjTEE6xnFEDkgoKwQF4rCGqM7JF9ZLKH+50AKDIkmvwy1Dov7FwUgw7Asp3GR
	u1i0BkqAAOCacwQUbubEivmA2dTO+YA3rT2RsOADuNC6WA03Myp9dXr0+8UuhO5N1AkFtjyif9F
	TGe1btgYliJKc5Uva1tbVpcrp9hmfgJ6XYkGqqMTJq/hIUavL9kzzCASGnWK/UqHb+9R3ho4Fom
	87qhUaZp9e/Oc9Riy4r2jzG6ySLtF7gvB8uEzT092BG+SpooN/K/5+V0r+RmrrIyFyCdpzAViuR
	5+bxzr7l+j2egsDACly/aeB4eoBvMFPkluWKwXt3cZIllyNzml0VwpZlUlHs/J4cR3RgV+CdvBQ
	mx7zu0tGjH+OE82LAzA5+UMvr
X-Google-Smtp-Source: AGHT+IGyFJgN6kHMNR99pNNeUGyYQV7NjbzXwXp+jyWzlg7CQqiV9MLuyd92oRaiCpm+ej3PcaWTng==
X-Received: by 2002:a05:690e:42d7:b0:633:b25a:f02f with SMTP id 956f58d0204a3-636045dd18cmr2177609d50.20.1758645224864;
        Tue, 23 Sep 2025 09:33:44 -0700 (PDT)
Received: from localhost ([140.82.166.162])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-eb366bbfb29sm501295276.25.2025.09.23.09.33.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 09:33:44 -0700 (PDT)
Date: Tue, 23 Sep 2025 11:33:43 -0500
From: Andrew Jones <ajones@ventanamicro.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, iommu@lists.linux.dev, 
	kvm-riscv@lists.infradead.org, kvm@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, zong.li@sifive.com, tjeznach@rivosinc.com, joro@8bytes.org, 
	will@kernel.org, robin.murphy@arm.com, anup@brainfault.org, atish.patra@linux.dev, 
	alex.williamson@redhat.com, paul.walmsley@sifive.com, palmer@dabbelt.com, alex@ghiti.fr
Subject: Re: [RFC PATCH v2 08/18] iommu/riscv: Use MSI table to enable IMSIC
 access
Message-ID: <20250923-b2caf55f4f87f05aaa619e0b@orel>
References: <20250920203851.2205115-28-ajones@ventanamicro.com>
 <20250922184336.GD1391379@nvidia.com>
 <20250922-50372a07397db3155fec49c9@orel>
 <20250922235651.GG1391379@nvidia.com>
 <87ecrx4guz.ffs@tglx>
 <20250923140646.GM1391379@nvidia.com>
 <20250923-b85e3309c54eaff1cdfddcf9@orel>
 <20250923152702.GB2608121@nvidia.com>
 <20250923-e459316700c55d661c060b08@orel>
 <20250923162302.GC2608121@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250923162302.GC2608121@nvidia.com>

On Tue, Sep 23, 2025 at 01:23:02PM -0300, Jason Gunthorpe wrote:
> On Tue, Sep 23, 2025 at 10:50:56AM -0500, Andrew Jones wrote:
> > Yes, this is the part that I'd like to lean on you for, since I understand
> > we want to avoid too much KVM/virt special casing for VFIO/IOMMUFD. I was
> > thinking that if I bit the bullet and implemented nested support than when
> > nesting was selected it would be apparent we're in virt context. However,
> > I was hoping to pull together a solution that works with current QEMU and
> > VFIO too.
> 
> You probably do have to make nested part of this, but I don't have a
> clear picture how you'd tie all the parts together through the nested
> API..
> 
> Somehow you have to load a msiptp that is effectively linked to the
> KVM reliably into the DC for the iommufd controlled devices that are
> linked to that KVM. Then synchronize with VFIO that this is done and
> it can setup KVM only interrupts somehow. This kvm entanglement is the
> "virt" you have mentioned many times.

Yes, the VFIO+KVM irqbypass framework currently provides much of this
support (which patches 10-17 of this series leverage). But, if using
nested is necessary in order to "signal" to the relevant subsystems that
the device's irqs will truly be isolated, then I'll need to start figuring
out how iommufd can fit into the mix (or if we'll need an iommufd-specific
implementation for a new mix).

> 
> The direct injection interrupt path is already quite a confusing
> thing..

No argument there :-)

Thanks,
drew
