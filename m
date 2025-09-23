Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA2D31E0B9C
	for <iommu@lists.linux.dev>; Tue, 23 Sep 2025 15:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758640367; cv=none; b=lBRMx8rMWUVLgFtMB6yghGrdIjx/4VoXJHQBxlj3JZNGPR9Y6ojAH7d+Y3qNyrrOPfKJ+STAcZP8eK3SLigidMmMRZ4eFPvUdrbbOZ7l7crfecbIwm1cc8riFg357Q31BuIp1b9zBzSnFOimLE5gCbnaznnoqnrNOBjPtHIYF+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758640367; c=relaxed/simple;
	bh=vasz5nshzs53EJtKEqVkeCvyDuQCp5OET50jfbjxrsc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gj0ZRoNNObxNRJjcaQyExt2ZncM9m2IR5cxZWdHrOnNXSYePrEu3foqJ0O7F7iKYyu5YlW2CHgApaKXzygMPPyHQot2BS0ENrJAr3NpGq9BMtS8eKWaFWQ85qQrAPaSqBPbv434NbyVdVtmIICTsFSGlMAI7wpMRoNPUzgkUeB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=crf8eOL2; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="crf8eOL2"
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-ea5c9dcba4bso3596332276.3
        for <iommu@lists.linux.dev>; Tue, 23 Sep 2025 08:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1758640365; x=1759245165; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IcoDQc5Q5w0LSP8tWH7zt/4vlU+pjxCSOZ2lxuUdQv4=;
        b=crf8eOL2iB1pfh0m084hBES13nF387Hn+jnn4QtMrXn6jUbNZ1RMAL6dVLB4xZ+Mvu
         1E8QS1iKAUBQylERy1t31pLi4jNYoI6koYEKbz83AzAONRPqCG3Y9r4UamnQW8RvBmqf
         rX2ptG0SKvgmdrNPU9n90mNoBBx2RkIujEMm5OI9wQ8KLAZGMDTdJBz2i7Ro0faJdmGA
         D5eWiH4N/Br7EKuHdJr9E6rdgg2MfZwOWyp5SDtTOINJTOKi58+V0o+m1sx9oR1xnWzp
         +czpfKO+peq63ZMWoGrW64r0wf3mtuIqdxK0iSk7mXsjeHcjLIQNWuJzSAYrRPRpUtx8
         tgsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758640365; x=1759245165;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IcoDQc5Q5w0LSP8tWH7zt/4vlU+pjxCSOZ2lxuUdQv4=;
        b=m1BYjyl9GwOmvvbq38n+SRvDiM5MhoJcoMJakCXXouNTXMHRSnyhFbr6BbhUZqnlD1
         3q7oZKkgYE4cTPA1MdRFxlkFpzkwGakaIfZU4KnOp18eab1UAiXjS4sqff2tqWNEYdme
         c37l3pY+AZAF75Yt2WNWd4PNN9XRZvsWVjkbgAz/l5eydtoCWUQYMaQS5MQV1j0pd0YJ
         fE8zbnHJHnv5iJWkkeYRTLKje4IQIdxqfqiYmMKPuEAuI+En8Jqkrkv9fUNIk4YMhNIW
         QKXJO31AU45yWBn4CW/h/Bksr7rdr364M29KOOhr27vZtrrvxf56HlyBt9QWIes+RPqe
         HySQ==
X-Forwarded-Encrypted: i=1; AJvYcCVQty/X2/w+2wTUmAXqM6zQPwl4Mq+HypT0fd+0rmtBsPkuBJO8aViJNWBx+uvcbXmAw6LgkQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwZspnHYcitvVexxc1+LQuh0+evsqJC34dBgHbCEmIav4+NUJDf
	X/ZRLsLar1y270gNWYCNULRmOHtwO/nrblHdG1zvURgQA+7iGdDHdeXKvQtOZJ9mFl4=
X-Gm-Gg: ASbGnctiVB/fuXk2wRpwanhhNHS1L45+nlS+w1rAEMQkCe+iCJbRKoT5qHA8v1wbkx2
	JvOa8xjUWRwqsTKyouOUjFWXSka3XDsOyQ1b3VXuJeKE0t4Y8vlTwK6FVi2k08VFhX6PuvrUbsy
	zPfjfr/0Y3RZv6PpiX7nxRHWPkZBYmAIeN/WfLj0W4EBvlFsZU+ffghocq5YLnrR5ESn3G+106g
	tF9p5SbQfxI8m7j+tKdXo4bUojXO1yAY9nqW4bhf07nqdJL0fye6Ab9nbl41f4IKieTy8Q4Pkoq
	ybwgOLu8IExw+y2N31yfYzrNDWKjQjqgQKVjG9X3GxQtCP16nO5oV7wTqhe+U21JKEP2NpJV2F4
	WX7yxnc6o7wBUI1aeVOmQ3YukXnPo3eSiKeI=
X-Google-Smtp-Source: AGHT+IEMS7urR+MAiaqL/uLW9oLtRDN0Kx2AZwEqvz53/Dorjr00baJwfX+lZDlIYthJJ5jr4bmaAw==
X-Received: by 2002:a05:6902:c0f:b0:ea4:302:9a8a with SMTP id 3f1490d57ef6-eb32e058783mr1870670276.6.1758640364669;
        Tue, 23 Sep 2025 08:12:44 -0700 (PDT)
Received: from localhost ([140.82.166.162])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-ea5ce974ac3sm5081124276.24.2025.09.23.08.12.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 08:12:44 -0700 (PDT)
Date: Tue, 23 Sep 2025 10:12:42 -0500
From: Andrew Jones <ajones@ventanamicro.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, iommu@lists.linux.dev, 
	kvm-riscv@lists.infradead.org, kvm@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, zong.li@sifive.com, tjeznach@rivosinc.com, joro@8bytes.org, 
	will@kernel.org, robin.murphy@arm.com, anup@brainfault.org, atish.patra@linux.dev, 
	alex.williamson@redhat.com, paul.walmsley@sifive.com, palmer@dabbelt.com, alex@ghiti.fr
Subject: Re: [RFC PATCH v2 08/18] iommu/riscv: Use MSI table to enable IMSIC
 access
Message-ID: <20250923-b85e3309c54eaff1cdfddcf9@orel>
References: <20250920203851.2205115-20-ajones@ventanamicro.com>
 <20250920203851.2205115-28-ajones@ventanamicro.com>
 <20250922184336.GD1391379@nvidia.com>
 <20250922-50372a07397db3155fec49c9@orel>
 <20250922235651.GG1391379@nvidia.com>
 <87ecrx4guz.ffs@tglx>
 <20250923140646.GM1391379@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250923140646.GM1391379@nvidia.com>

On Tue, Sep 23, 2025 at 11:06:46AM -0300, Jason Gunthorpe wrote:
> On Tue, Sep 23, 2025 at 12:12:52PM +0200, Thomas Gleixner wrote:
> > With a remapping domain intermediary this looks like this:
> > 
> >      [ CPU domain ] --- [ Remap domain] --- [ MSI domain ] -- device
> >  
> >    device driver allocates an MSI interrupt in the MSI domain
> > 
> >    MSI domain allocates an interrupt in the Remap domain
> > 
> >    Remap domain allocates a resource in the remap space, e.g. an entry
> >    in the remap translation table and then allocates an interrupt in the
> >    CPU domain.
> 
> Thanks!
> 
> And to be very crystal clear here, the meaning of
> IRQ_DOMAIN_FLAG_ISOLATED_MSI is that the remap domain has a security
> feature such that the device can only trigger CPU domain interrupts
> that have been explicitly allocated in the remap domain for that
> device. The device can never go through the remap domain and trigger
> some other device's interrupt.
> 
> This is usally done by having the remap domain's HW take in the
> Addr/Data pair, do a per-BDF table lookup and then completely replace
> the Addr/Data pair with the "remapped" version. By fully replacing the
> remap domain prevents the device from generating a disallowed
> addr/data pair toward the CPU domain.
> 
> It fundamentally must be done by having the HW do a per-RID/BDF table
> lookup based on the incoming MSI addr/data and fully sanitize the
> resulting output.
> 
> There is some legacy history here. When MSI was first invented the
> goal was to make interrupts scalable by removing any state from the
> CPU side. The device would be told what Addr/Data to send to the CPU
> and the CPU would just take some encoded information in that pair as a
> delivery instruction. No state on the CPU side per interrupt.
> 
> In the world of virtualization it was realized this is not secure, so
> the archs undid the core principal of MSI and the CPU HW has some kind
> of state/table entry for every single device interrupt source.
> 
> x86/AMD did this by having per-device remapping tables in their IOMMU
> device context that are selected by incomming RID and effectively
> completely rewrite the addr/data pair before it reaches the APIC. The
> remap table alone now basically specifies where the interrupt is
> delivered.
> 
> ARM doesn't do remapping, instead the interrupt controller itself has
> a table that converts (BDF,Data) into a delivery instruction. It is
> inherently secure.

Thanks, Jason. All the above information is very much appreciated,
particularly the history.

> 
> That flag has nothing to do with affinity.
>

So the reason I keep bringing affinity into the context of isolation is
that, for MSI-capable RISC-V, each CPU has its own MSI controller (IMSIC).
As riscv is missing data validation its closer to the legacy, insecure
description above, but the "The device would be told what Addr/Data to
send to the CPU and the CPU would just take some encoded information in
that pair as a delivery instruction" part becomes "Addr is used to select
a CPU and then the CPU would take some encoded information in Data as the
delivery instruction". Since setting irq affinity is a way to set Addr
to one of a particular set of CPUs, then a device cannot raise interrupts
on CPUs outside that set. And, only interrupts that the allowed set of
CPUs are aware of may be raised. As a device's irqs move around from
irqbalance or a user's selection we can ensure only the CPU an irq should
be able to reach be reachable by managing the IOMMU MSI table. This gives
us some level of isolation, but there is still the possibility a device
may raise an interrupt it should not be able to when its irqs are affined
to the same CPU as another device's and the malicious/broken device uses
the wrong MSI data. For the non-virt case it's fair to say that's no where
near isolated enough. However, for the virt case, Addr is set to guest
interrupt files (something like virtual IMSICs) which means there will be
no other host device or other guest device irqs sharing those Addrs.
Interrupts for devices assigned to guests are truly isolated (not within
the guest, but we need nested support to fully isolate within the guest
anyway).

In v1, I tried to only turn IRQ_DOMAIN_FLAG_ISOLATED_MSI on for the virt
case, but, as you pointed out, that wasn't a good idea. For v2, I was
hoping the comment above the flag was enough, but thinking about it some
more, I agree it's not. I'm not sure what we can do for this other than
an IOMMU spec change at this point.

Thanks,
drew
