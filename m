Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EC5637A840;
	Wed, 14 Oct 2026 08:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791967095; cv=none; b=qtffXDcT90EPLorlCOi1arNOwJ6GuKx4c/k84f+CoAwNw2tAYEuuVeWDbXNM8I01I10EubnKVAvvao986sw0ycLNaQFplRXF0gZtVidoklGZhuDfNtB/TsTaio5f9IeMU537htmyWQYYaq+JXFB3Etf8DSvI3C96q7SszfFRvm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791967095; c=relaxed/simple;
	bh=YyHDUboAl8DGIwqb8WSL+sGNujn8F87tNepM8aGf6uY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=AeaWQTCv+8dhKTShVQSRuW8Ybk+xRas+IDXd2FyswbKfjEsxE7QXocu46gdp5hyInHA/jqbldWTSdn4vDFYC45pBDTaI4kGCv/ybFyjhvmfkASwynsiEAdC4BhB7vn9/K+C7SIDDw6BJzKge4U5PLcNeiZMGkkYZDKZmQaEbY4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZBkdOjI5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZBkdOjI5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E22CE1F000FF;
	Wed, 14 Oct 2026 08:38:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791967094;
	bh=YyHDUboAl8DGIwqb8WSL+sGNujn8F87tNepM8aGf6uY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=ZBkdOjI5xFHLM/lUIbuC1rvH1kdnsHjIlxqalBInWP+3FvNSchmjKTmg5JwB47uWb
	 lEsyz90U9qVC3roXg5+59U2YKl4Q/eS32I7+EGZ9+8HziCTHZDrHSUqXjxpmGXqjfP
	 6ZRONkjp2lFXVMgpbbYPRq8HT+CkX7xnAmbcelbSgurdI82dsTOrIFjEbmY8KO1wAh
	 W5XxVs/TjxaryAGuRP6E8DRq1+rs2gZzLbmHmlvPoo3+rrGB9cMD8DL7LHsnG3guQR
	 uIj1zsJ7IYy/Rq63L7fXIuJuHZhMZmC8/Y28mUlSs3R2AS+zt85OQWIhB3bqunw7Dr
	 /Krsj9P8fmdVg==
X-Mailer: emacs 31.1 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Ackerley Tng <ackerleytng@google.com>, linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Alex Williamson <alex@shazbot.org>,
	David Woodhouse <dwmw2@infradead.org>,
	David Hildenbrand <david@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	"Joerg Roedel (AMD)" <joro@8bytes.org>,
	Kevin Tian <kevin.tian@intel.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Sean Christopherson <seanjc@google.com>,
	Will Deacon <will@kernel.org>,
	Alexey Kardashevskiy <aik@amd.com>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Steven Price <steven.price@arm.com>,
	Fred Griffoul <griffoul@gmail.com>, iommu@lists.linux.dev,
	kvm@vger.kernel.org
Subject: Re: [RFC PATCH v1 0/6] KVM/VFIO: guest_memfd support for device
 MMIO resources
In-Reply-To: <CAEvNRgFC6U4er0QhcwVOqWyz657WWWtidkNu0hKS5go4A3cP4g@mail.gmail.com>
References: <20261010072504.536230-1-aneesh.kumar@kernel.org>
 <CAEvNRgFC6U4er0QhcwVOqWyz657WWWtidkNu0hKS5go4A3cP4g@mail.gmail.com>
Date: Wed, 14 Oct 2026 14:08:04 +0530
Message-ID: <yq5a7bjky8wj.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

Ackerley Tng <ackerleytng@google.com> writes:

> "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org> writes:
>
>> This series adds a guest_memfd device-resource framework for exposing PCI
>> BAR memory to guests. The intended use is confidential device assignment,
>> where KVM needs to coordinate private device mappings with shared access
>> through VFIO. The Arm CCA backend is provided separately; these patches
>> contain the guest_memfd, VFIO and IOMMUFD interfaces it uses.
>>
>
> Thank you Aneesh!
>
> I definitely like this since it builds upon [1], the model where
> guest_memfd coordinates zapping during conversions for the
> provider. Please see comparison with the alternative at [2].
>
>>
>> [...snip...]
>>
>
> I have questions:
>
>> Userspace creates a device-backed guest_memfd using the ordinary VFIO
>> device fd as resource_fd, with GUEST_MEMFD_FLAG_USE_RESOURCE,
>> GUEST_MEMFD_FLAG_DEVICE
>
> With the model described at [1][2][3], I was thinking that the VFIO fd
> would be the resource fd. I'm hoping that there wouldn't be a need for
> GUEST_MEMFD_FLAG_DEVICE.
>
> The plan [3] was for resource fd to represent just the resource but not
> provide any way to access the underlying resource, so that after
> .attach(), guest_memfd's fd should be the way userspace would access the
> underlying resource.
>
> For tmpfs, the example in [1], fsmount() returns an fd that has no
> .mmap/.read/.write ops, which fits the plan above perfectly. It tells
> guest_memfd about the resource, but does not give userspace access to
> the resource.
>
> In VFIO's case, vfio_device_fops does implement .mmap()/.read/.write,
> and I don't think there's a better existing fd that represents a single
> device.
>

With VFIO, after attachment we can reject new mmap() calls by checking
the attachment status in vfio_pci_core_mmap(). During attachment, we can
reject the operation if the VFIO fd already has an mmap. But I guess
read(), write(), and VFIO_DEVICE_IOEVENTFD should still operate through
the VFIO fd, or are you suggesting that all of them operate through
guest_memfd?

I am not sure we want to move the ioeventfd ioctl out of VFIO. If it
remains there, userspace needs write access to shared BAR regions via
vfio fd, so it would make sense to continue allowing read() and write()
as well. If we allow read() and write(), should we also allow mmap()?

I agree that keeping userspace mappings(mmap) under guest_memfd rather
than VFIO simplifies conversion. The conversion then becomes:

unmap_mapping_pages(inode->i_mapping, start, nr_pages, true); //unmap user mapping
kvm_gmem_invalidate_start(inode, start, start + nr_pages, KVM_FILTER_SHARED); // stage2 unmap


Both are now under guest_memfd control, so no VFIO callback is needed.

>
>> and GUEST_MEMFD_FLAG_INIT_SHARED. Eligible BAR
>> intervals are registered as guest_memfd memslots. File offsets use the
>> existing VFIO region-offset namespace, allowing one guest_memfd to cover
>> multiple BAR intervals. Device-backed guest_memfd rejects mmap and
>> fallocate; shared guest faults obtain bare BAR PFNs from the provider
>> instead of resolving the memslot HVA or allocating folios.
>>
>
> The model I have in mind is kind of opposite from above. Instead of the
> guest_memfd rejecting mmap(), I'm thinking that the VFIO fd should be
> the one that rejects mmap(), read() and write() once guest_memfd
> attaches to it.
>
> If userspace needed to mmap() the VFIO fd, it should instead mmap() the
> guest_memfd fd. guest_memfd doesn't support read() and write() now, but
> support can be added. The read/write for guest_memfd just forwards to
> vfio if the offset range is shared and blocks if the range is
> private.
>
> For mmap(), for regular memory, mmap() is always allowed, but faulting
> dependsd on shared/private status. It would be nice if the same logic
> could apply to guest_memfds that wrap VFIO.
>
> I prefer the userspace accesses to go through guest_memfd to VFIO so
> that the shared/private-ness can be enforced from guest_memfd.
>

Sure, I can implement this. I guess read(), write(), and ioeventfd will
continue to go through the VFIO fd?

>
>
> Is GUEST_MEMFD_FLAG_DEVICE there because GUEST_MEMFD_FLAG_USE_RESOURCE
> tells guest_memfd to look up
> resource_inode->i_sb->s_op->gmem_provider_ops but for VFIO,
> gmem_provider_ops can't be stored in super_operations? If that's the
> only reason, that's a very good reason to store gmem_provider_ops in
> file_operations for gmem_provider_ops to serve different kinds resources
> and include VFIO.
>

I can use the same approach for VFIO. I kept the current implementation
simpler by using a registration framework on the VFIO side.

I can switch to gmem_provider_ops if we are comfortable adding the
device-specific callbacks to guest_memfd_provider_operations. Since the
VFIO core supports multiple backend drivers, such as vfio-pci, the
superblock operations would essentially forward the calls to the
appropriate backend driver. That is a VFIO-specific detail that
guest_memfd can ignore.

>
> I also noticed the need to guest_memfd_register_device_fops, so that
> guest_memfd knows the device supports being attached to?
>
> What do you think of this: we have a common attach function for all VFIO
> fds in file_operations that would look up the struct vfio_device to
> determine if guest_memfd can attach to the vfio device? Actually, which
> devices would not support attaching? Wouldn't all devices support
> attaching? I'm thinking that using a device that is all-shared via
> guest_memfd should be no different from using the device directly. All
> operations should flow through to the device.
>

>
> Regarding conversions, I would like to check: with Confidential IO, are
> conversions at runtime actually necessary?
>

They occur at runtime after the guest starts, but are infrequent. The
entire region starts shared. The guest validates the interface report and
requests that the BAR regions be mapped private. They remain private until
the host converts them back to shared during the TDISP unlock operation.

>
> Is the only "conversion" the one when the guest accepts a device? If so,
> maybe that "conversion" can be implemented by replacing memslots.
>
> Pre-accept, mmap() the vfio fd directly, set it up in memslots.
>
> Post-accept, remove the old memslot, wrap the vfio fd with guest_memfd,
> set up the guest_memfd statically with shared/private ranges as the TDI
> report requested and never allow conversions, replace the pre-accept
> memslot.
>

Is there a reason to use two different flows here? Why can't we always
use guest_memfd? We could attach the device at startup and use
guest_memfd before acceptance, while the BAR is mapped shared. We would
not need mmap() unless userspace requires it for another reason; the VM
fault handler could fault in those PFNs.

During device acceptance, we convert those BARs to private. On CCA, we
also create the stage2 mappings at that point, since private BAR regions
do not support fault handling.

>
>> IOMMUFD resolves and pins the device's existing vDEVICE for the VM and
>> serializes MMIO conversion through its MMIO mutex. VFIO supplies BAR PFNs,
>> checks eligible ranges and excludes independent dma-buf exports while a
>> guest_memfd provider is attached. VFIO host mmap faults, read/write and
>> ioeventfd accesses check the requested range's guest_memfd attributes.
>> Conversion revokes cached host mappings and shared guest mappings before
>> installing private mappings. Other shared intervals remain accessible.
>>
>>
>> [...snip...]
>>
>
> [1] https://lore.kernel.org/all/20260925-gmem-tmpfs-backend-v1-0-d36159822d18@google.com/
> [2] https://lore.kernel.org/all/CAEvNRgEseLO+LbkwXrEit0H2LH5Wx-srSvHEMpt0=upPL3tF=g@mail.gmail.com/
> [3] https://lpc.events/event/20/contributions/2551/attachments/2047/4693/lpc-2026-gmem-other-backends.pdf

-aneesh
