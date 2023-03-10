Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0669463B5
	for <iommu@lists.linux.dev>; Fri, 10 Mar 2023 12:16:03 +0000 (UTC)
Received: by mail-wm1-f52.google.com with SMTP id m25-20020a7bcb99000000b003e7842b75f2so3272413wmi.3
        for <iommu@lists.linux.dev>; Fri, 10 Mar 2023 04:16:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678450562;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KoNK7gOAZ0oywAGu2z7WPtU1u7GnN09K9Wgxc/GvSWc=;
        b=pdg8LlhXhMUwas9rQklA0yeP3bqWGn5raQs0PitHqZrmu2LRh2ZwaFTB68nCj9S9Ug
         Z8cG4CtAC7/y/0H8E9PZ9By9Rya7ppN55SUWzwoQzPJe+4IcdOYa7vlMe7qDDWhzvIqp
         +8wsjbWhygNabvCywEsF6tEmZ42Jsjh1/yrRnFgDn7+xD8MVK14HRiXIs8u2JCle5hbK
         6uEE+ncuU+tx1A6XD+qA8+637gMK21Qw+fJST836TJm2Kr3PFoc5SQ0l9DeqIEsdsmrX
         PY4RUQU1rtoHdu7rqww2BJd9Jmiw6VG39ebfWHu+5FIdR7lpSvQJA+rgQ7Ji3WXcSWLB
         bGIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678450562;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KoNK7gOAZ0oywAGu2z7WPtU1u7GnN09K9Wgxc/GvSWc=;
        b=wJsOQQczRNHUkGn47tAOwk5QglRhE8U9AxmnKpn6M9LWLBiNmtpFNULjKlJDePtlZN
         PQhucfEDlFP4lCu+I6Xg09PSu28uMv/hmln4HGAZ9nkYwq0UBgWN5aWWr7E8jJmLPDzs
         /52eeT5tOzgLW0VrE19Kwkkr7iON3Bsjvi8cOgOA7w0HmmaaxvBsvd/nE/EErxU3E00i
         6RRmj5QEk467nNH/e9kL/KhNx+xwzwysc+K3KMu+07qumZKc/rQuHXzBL3/TYI911YHn
         4x6wvcf8iz87wK0qztiBp5ibL9pPkco9FBAQa4eq1OmzthzX5SBsiul26uW2EiWMgXxd
         Vf1A==
X-Gm-Message-State: AO0yUKWjwBDb2tO+YlpeYbgqT/kVA3q/JYgV9FReQsBMvenb2ZJllbPQ
	oxGX5cyGqVWmPqBwo6qYsYoLnw==
X-Google-Smtp-Source: AK7set/u+LYEhjoy3aHn9qaI7ZtcpW2lMWxRw935XoWMUCoTCahCUKIFrTWtmCyX/6GGi7HcPZupMw==
X-Received: by 2002:a05:600c:3ca2:b0:3eb:3104:efec with SMTP id bg34-20020a05600c3ca200b003eb3104efecmr2595889wmb.16.1678450562210;
        Fri, 10 Mar 2023 04:16:02 -0800 (PST)
Received: from myrica (054592b0.skybroadband.com. [5.69.146.176])
        by smtp.gmail.com with ESMTPSA id i22-20020a1c5416000000b003dc49e0132asm2920264wmb.1.2023.03.10.04.16.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 04:16:01 -0800 (PST)
Date: Fri, 10 Mar 2023 12:16:03 +0000
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>, robin.murphy@arm.com,
	will@kernel.org, eric.auger@redhat.com, kevin.tian@intel.com,
	baolu.lu@linux.intel.com, joro@8bytes.org,
	shameerali.kolothum.thodi@huawei.com,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, yi.l.liu@intel.com
Subject: Re: [PATCH v1 02/14] iommufd: Add nesting related data structures
 for ARM SMMUv3
Message-ID: <20230310121603.GA1745536@myrica>
References: <cover.1678348754.git.nicolinc@nvidia.com>
 <364cfbe5b228ab178093db2de13fa3accf7a6120.1678348754.git.nicolinc@nvidia.com>
 <20230309134217.GA1673607@myrica>
 <ZAnx0lUkw02cVTi+@nvidia.com>
 <20230309182659.GA1710571@myrica>
 <ZApJGwPjHhlDwTDV@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZApJGwPjHhlDwTDV@nvidia.com>

On Thu, Mar 09, 2023 at 05:01:15PM -0400, Jason Gunthorpe wrote:
> > Concretely though, what are the incompatibilities between the HW designs?
> > They all need to remove a range of TLB entries, using some address space
> > tag. But if there is an actual difference I do need to know.
> 
> For instance the address space tags and the cache entires they match
> to are wildly different.
> 
> ARM uses a fine grained ASID and Intel uses a shared ASID called a DID
> and incorporates the PASID into the cache tag.
> 
> AMD uses something called a DID that covers a different set of stuff
> than the Intel DID, and it doesn't seem to work for nesting. AMD uses
> PASID as the primary nested cache tag.

Thanks, we'll look into that


> This is because SMMUv3 has no option to keep the PASID table in the
> hypervisor so you are sadly forced to expose both the native ASID and
> native PASID caches to the virtio protocol.

It is possible to keep the PASID table in the host, but you need a way to
allocate GPA since the SMMU accesses it after stage-2 translation. I think
that necessarily requires a PV interface, but you could look into it.
Anyway, even with that, ATC invalidations take a PASID.

> 
> Given that the VM virtio driver has to have SMMUv3 specific code to
> handle the CD table it must get, I don't see the problem with also
> having SMMUv3 specific code in the hypervisor virtio driver to handle
> invalidating based on the CD table.

There isn't much we can't do, I'm just hoping to build something
straightforward instead of having to work around awkward interfaces


> > A couple of reasons are relevant here: non-QEMU VMMs don't want to emulate
> > all vendor IOMMUs, new architectures get vIOMMU mostly for free,
> 
> So your argument is you can implement a simple map/unmap API riding
> on the common IOMMU API and this is portable?
> 
> Seems sensible, but that falls apart pretty quickly when we talk about
> nesting.. I don't think we can avoid VMM components to set this up, so
> it stops being portable. At that point I'm back to asking why not use
> the real HW model?

A single VMM component that shovels data from the virtqueue to the kernel
API and back, rather than four different hardware emulations, four
different queues, four different device tables. It's obviously better for
VMMs that don't do full-system emulation like QEMU, especially as they
generally already implement a virtio transport. Smaller attack surface,
fewer bugs.

The VMM developer gets a multi-platform vIOMMU without having to study all
the different architecture manuals. There is a small amount of HW specific
data in there, but it only relates to table formats. 

Ideally it wouldn't need any HW knowledge, but that would requires the
APIs to be aligned: instead of ID registers we pass plain features, and
invalidations don't require HW specific opcodes. Otherwise there is going
to be a layer of glue everywhere, which is what I'm trying to avoid here.

> 
> > > All the iommu drivers have native command
> > > queues. ARM and AMD are both supporting native command queues directly
> > > in the guest, complete with a direct guest MMIO doorbell ring.
> > 
> > Arm SMMUv3 mandates a single global command queue (SMMUv2 uses
> > registers). An SMMUv3 can optionally implement multiple command
> > queues, though I don't know if they can be safely assigned to
> > guests.
> 
> It is not standardized by ARM, but it can (and has) been done.
> 
> > For a lot of SMMUv3 implementations that have a single queue and for
> > other architectures, we can do better than hardware emulation.
> 
> How is using a SW emulated virtio formatted queue better than using a
> SW emulated SMMUv3 ECMDQ?

We don't need to repeat it for all IOMMU architectures, not emulate a new
queue in the kernel. The first motivator for virtio-iommu was avoiding to
emulate hardware in the kernel. The SMMU maintainer saw how painful that
was to do for the GIC, saw that there is a virtualization queue readily
available in vhost and, well, it just made sense. Still does.


> > As above, decoding arch-specific structures into generic ones is what an
> > emulated IOMMU does,
> 
> No, it is what virtio wants to do. We are deliberately trying not to
> do that for real accelerated HW vIOMMU emulators.

Yes there is a line somewhere, and I'd prefer it to be the page table.
Given how many possible hardware combinations exist and how many more will
show up, it would be good to abstract things where possible.

> 
> > and it doesn't make a performance difference in which
> > format it forwards that to the kernel. The host IOMMU driver checks the
> > guest request and copies them into the command queue. Whether that request
> > comes in the form of a structure binary-compatible with Arm SMMUvX.Y, or
> > some generic structure, does not make a difference.
> 
> It is not the structure layouts that matter!
> 
> It is the semantic meaning of each request, on each unique piece of
> hardware. We actually want to leak the subtle semantic differences to
> userspace.

These are hardware emulations, of course they have to know about hardware
semantics. The QEMU IOMMUs can work in TCG mode where they decode and
handle everything themselves.

Thanks,
Jean
