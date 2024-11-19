Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45D251CFED1
	for <iommu@lists.linux.dev>; Tue, 19 Nov 2024 15:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732030587; cv=none; b=f0YWV7AArVwnVwoW1raddJW1tBXmNrLwvMZtMoJlRDqp6+6LpGMQLt6XFQ/zAEfDYu+YFPDajes10ZNair1di7aMyqLeLXe8xrRWR6SxmKL8uDbi0scnQbb7GqaHgy3w8kk08Y/Hk5p/k+uh/8/E1rWUBoxf0NpAA4S5+H4WqHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732030587; c=relaxed/simple;
	bh=JCkAA68ZY+WP8IwqIAvaFpW2nHxEvQxCVSX6gB3J6/s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vxv3r3qCcf3ypYCj2t7/apk1YhJtAtSY9vPwCRZRve83LEtqnrquGm8aCyyB0yPJFjYBgK3ypYvz7ZEOe9fktSAEQA+JMxMmL0tNqDTokSAVe3ev00lP34leHH1fPQrV7HT1/KFj+FAgjR/MEjjdYbvE4keYp63ZkUSH45D+9Ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Ub4KtZr8; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Ub4KtZr8"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7b147a2ff04so243941385a.3
        for <iommu@lists.linux.dev>; Tue, 19 Nov 2024 07:36:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1732030584; x=1732635384; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3mHQxzFmFKlA+b0zYZcHoo+aU2zGMKGJLF0Y2reUtOA=;
        b=Ub4KtZr8ZLnQcH5gPzvyiV/vpFfQBavDmIHt5ZWB2YS5Pp3yBRSFdGY8POFx5Ibubj
         AMlJMAXdlEh4fudraZkn736B245F7bs7cSu8rmTKNMLYiJE4QD6jDD8JmsC8j3Fq0xkm
         8IzFG2LCgZZHZUOBAlhALb0mGZwDQYSgC7+DeqMZYlHpXxHtxgmN22YteiFYjS99lABy
         7PuS6aTZNZ837DIUXtLbFOvvTMPkZ/agNtzUS4VJ31S9KYuqOErOqAu4atAdiUVJDFbz
         yA3NGMtdQa+CBnH7LfP7S+xSa+9qOBlarAHyG/sy5BPoH4dOr4YcUAyKlqbFDFvxz0r/
         3GUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732030584; x=1732635384;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3mHQxzFmFKlA+b0zYZcHoo+aU2zGMKGJLF0Y2reUtOA=;
        b=ijjIErntovC68SejEyrFXUmFCLm89Yz9X/2oy326jlrevMguW29uxjWLyCzBoKqeTp
         UMzgKgHQSVoaVmMd/00xQ1tX2j7T4eh712k2gDUAxz7sDUvy34nUePFk1TLjq9BegmY9
         CGOy+ComiizVZWCklh69abreGUbIjjnIGzb6s8olLagv0MBygQ6Z8O/DQY5ytxtcmrbL
         HIbsnJElp4+MCVzeSyOUbX1fEfj5SU8HQpn4EbpLvftMR7tiZw2gPvCG9tFPo2nFBdra
         C+c2p+i6KMA17+5FLX+AQc6505pRGiyyXXwJ5Y/JlrktkNVjfwR9oZHF0tN8opUhjt8z
         HGag==
X-Gm-Message-State: AOJu0YxRMdNbZDd3eH7OePMiKOSCttSHscpNXivvWhSPWAG1UmbmXwjn
	f5CcRC62spcvygKf6daZIUhwuUtapMSqgZ3uwQP2qpbbZMfQgEW/OGNgLtnDSB4=
X-Google-Smtp-Source: AGHT+IH4/mgl4haITeaqcVAP0uJ0PicTb/W5vrOpJN7LD+UFoRrLptgSOiQTXdZYlGY+OxnTFThNlg==
X-Received: by 2002:a05:620a:28d1:b0:7ac:b04e:34c6 with SMTP id af79cd13be357-7b362363c62mr1842987085a.50.1732030583616;
        Tue, 19 Nov 2024 07:36:23 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b37a89fc13sm102554185a.109.2024.11.19.07.36.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2024 07:36:22 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1tDQH8-00000003ErC-0NkI;
	Tue, 19 Nov 2024 11:36:22 -0400
Date: Tue, 19 Nov 2024 11:36:22 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Andrew Jones <ajones@ventanamicro.com>
Cc: iommu@lists.linux.dev, kvm-riscv@lists.infradead.org,
	kvm@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, tjeznach@rivosinc.com,
	zong.li@sifive.com, joro@8bytes.org, will@kernel.org,
	robin.murphy@arm.com, anup@brainfault.org, atishp@atishpatra.org,
	tglx@linutronix.de, alex.williamson@redhat.com,
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu
Subject: Re: [RFC PATCH 08/15] iommu/riscv: Add IRQ domain for interrupt
 remapping
Message-ID: <20241119153622.GD559636@ziepe.ca>
References: <20241114161845.502027-17-ajones@ventanamicro.com>
 <20241114161845.502027-25-ajones@ventanamicro.com>
 <20241118184336.GB559636@ziepe.ca>
 <20241119-62ff49fc1eedba051838dba2@orel>
 <20241119140047.GC559636@ziepe.ca>
 <DE13E1DF-7C68-461D-ADCD-8141B1ACEA5E@ventanamicro.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DE13E1DF-7C68-461D-ADCD-8141B1ACEA5E@ventanamicro.com>

On Tue, Nov 19, 2024 at 04:03:05PM +0100, Andrew Jones wrote:

> >This is the wrong thinking entirely. There is no such thing as a "VFIO
> >domain".
> >
> >Default VFIO created domains should act excatly the same as a DMA API
> >domain.
> >
> >If you want your system to have irq remapping, then it should be on by
> >default and DMA API gets remapping too. There would need to be a very
> >strong reason not to do that in order to make something special for
> >riscv. If so you'd need to add some kind of flag to select it.
> >
> >Until you reach nested translation there is no "need" for VFIO to use
> >any particular stage. The design is that default VFIO uses the same
> >stage as the DMA API because it is doing the same basic default
> >translation function.
> 
> The RISC-V IOMMU needs to use g-stage for device assignment, if we
> also want to enable irqbypass, because the IOMMU is specified to
> only look at the MSI table when g-stage is in use. This is actually
> another reason the irq domain only makes sense for device
> assignment.

Most HW has enablable interrupt remapping and typically Linux just
turns it always on.

Is there a reason the DMA API shouldn't use this translation mode too?
That seems to be the main issue here, you are trying to avoid
interrupt remapping for DMA API and use it only for VFIO, and haven't
explained why we need such complexity. Just use it always?

> >Nested translation has a control to select the stage, and you can
> >then force the g-stage for VFIO users at that point.
> 
> We could force riscv device assignment to always be nested, and when
> not providing an iommu to the guest, it will still be single-stage,
> but g-stage, but I don't think that's currently possible with VFIO,
> is it?

That isn't what I mean, I mean you should not be forcing the kind of
domain being created until you get to special cases like nested.

Default VFIO should work the same as the DMA API.

> >> The IRQ domain will only be useful for device assignment, as that's when
> >> an MSI translation will be needed. I can't think of any problems that
> >> could arise from only creating the IRQ domain when probing assigned
> >> devices, but I could certainly be missing something. Do you have some
> >> potential problems in mind?
> >
> >I'm not an expert in the interrupt subsystem, but my understanding was
> >we expect the interrupt domains/etc to be static once a device driver
> >is probed. Changing things during iommu domain attach is after drivers
> >are probed. I don't really expect it to work correctly in all corner
> >cases.
> 
> With VFIO the iommu domain attach comes after an unbind/bind, so the
> new driver is probed.

That's the opposite of what I mean. The irq domain should be setup
*before* VFIO binds to the driver.

Changing the active irq_domain while VFIO is already probed to the
device is highly unlikely to work right in all cases.

> I think that's a safe time. However, if there
> could be cases where the attach does not follow an unbind/bind, then
> I agree that wouldn't be safe.

These cases exist.

> I'll consider always creating an IRQ
> domain, even if it won't provide any additional functionality unless
> the device is assigned.

That isn't ideal, the translation under the IRQs shouldn't really be
changing as the translation under the IOMMU changes.

Further, VFIO assumes iommu_group_has_isolated_msi(), ie
IRQ_DOMAIN_FLAG_ISOLATED_MSI, is fixed while it is is bound. Will that
be true if the iommu is flapping all about? What will you do when VFIO
has it attached to a blocked domain?

It just doesn't make sense to change something so fundamental as the
interrupt path on an iommu domain attachement. :\

> >VFIO is allowed to change the translation as it operates and we expect
> >that interrupts are not disturbed.
> 
> The IRQ domain stays the same during operation, the only changes are
> the mappings from what the guest believes are its s-mode interrupt
> files to the hypervisor selected guest interrupt files, and these
> changes are made possible by the IRQ domain's vcpu-affinity support.

That is only the case when talking about kvm, this all still has to
work fully for non-kvm VFIO uses cases too.

Jason
