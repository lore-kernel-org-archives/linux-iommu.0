Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEAD529BDBF;
	Fri, 16 Oct 2026 05:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792126904; cv=none; b=PAeEan4NtCueC67809xhOe9rYrY+ZTNdT7f7MrDHrEer81UN2IDiIPAlAXtRqQXs4pYkhitEevYnUdFgHLt/GKWrD1N+9uFvQBNYRyxdAg0sbwKUQpkXuzUt4PRVknpkPt38wgJEqOve8fzSsdDvWWO8T6czsPOLv05BB2uvEUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792126904; c=relaxed/simple;
	bh=cp/8ZH70V0YhpApmeacsEDAWX/CjCq97e5vSV5J0w84=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HV8X2SQDaIPGnXunQjIduRYOcf19pjhZlnIQzdsHHfu4amLP0+Eusp55OvfRPshiK/kKXBm+JD3AEiZXGJ2RmJuLI39PZ3b7ENwgKjMUm7g/B9rQaUntKejmM7aYkIsbTfuHbGTw9vaFvbMJ5K5E7hhW9THfRrvbR7EF76HdE04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=INUpwWrh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="INUpwWrh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7065C1F000C4;
	Fri, 16 Oct 2026 05:01:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792126900;
	bh=wBHVgRNlDXmJ9HUEA20sbn0bEvYmP0JVoW+8PHQ8V0M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=INUpwWrhrdPP3yOkkwrjvoJ14JWbj9S/C7pMLAUyqdr81RnC/fnNT6V7VqZuwp00C
	 IdxXfSDGp7VejD925Uf9QQt3QzkXrtLup5VU2fmyKWXjD1AIJng8KZr7dMoD/iPC+i
	 7AaSDOluPGyWTSGkxbXNzr/mBLRO3YESiOa0e1BZBSWhMH9We0RFIDqDzsqDe5uwv5
	 hRChSRwiuN0lJ86puV2gehsIobiAFpmDQ6RYCiwFCVDlCuf2cgv1AyhAfsgx7T7GEI
	 HjhMycz89L0BKAx3DCG2KCPw5ZlhKymbe33Yc3uh9+H0L0ixWNfQ5KLP8xBpkRxJHr
	 cTu7qJ/mShIkg==
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
	kvm@vger.kernel.org, john.starks@microsoft.com,
	jacob.pan@linux.microsoft.com, gourry@gourry.net,
	vannapurve@google.com, fvdl@google.com, tabba@google.com,
	dave.jiang@intel.com
Subject: Re: [RFC PATCH v1 0/6] KVM/VFIO: guest_memfd support for device
 MMIO resources
In-Reply-To: <CAEvNRgGfjHhVCxHhew8AMKhXrX6XDrbrw5zpQM9LaODhJHRYYg@mail.gmail.com>
References: <20261010072504.536230-1-aneesh.kumar@kernel.org>
 <CAEvNRgFC6U4er0QhcwVOqWyz657WWWtidkNu0hKS5go4A3cP4g@mail.gmail.com>
 <yq5a7bjky8wj.fsf@kernel.org>
 <CAEvNRgGfjHhVCxHhew8AMKhXrX6XDrbrw5zpQM9LaODhJHRYYg@mail.gmail.com>
Date: Fri, 16 Oct 2026 10:31:27 +0530
Message-ID: <yq5a1p9qxmqg.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

Ackerley Tng <ackerleytng@google.com> writes:

> Aneesh Kumar K.V <aneesh.kumar@kernel.org> writes:
>
>> Ackerley Tng <ackerleytng@google.com> writes:
>>
>>> "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org> writes:
>>>

 [ ... 65 lines skipped ... ] 

>
>>>
>>>> and GUEST_MEMFD_FLAG_INIT_SHARED. Eligible BAR
>>>> intervals are registered as guest_memfd memslots. File offsets use the
>>>> existing VFIO region-offset namespace, allowing one guest_memfd to cover
>>>> multiple BAR intervals. Device-backed guest_memfd rejects mmap and
>>>> fallocate; shared guest faults obtain bare BAR PFNs from the provider
>>>> instead of resolving the memslot HVA or allocating folios.
>>>>
>>>
>>> The model I have in mind is kind of opposite from above. Instead of the
>>> guest_memfd rejecting mmap(), I'm thinking that the VFIO fd should be
>>> the one that rejects mmap(), read() and write() once guest_memfd
>>> attaches to it.
>>>
>>> If userspace needed to mmap() the VFIO fd, it should instead mmap() the
>>> guest_memfd fd. guest_memfd doesn't support read() and write() now, but
>>> support can be added. The read/write for guest_memfd just forwards to
>>> vfio if the offset range is shared and blocks if the range is
>>> private.
>>>
>>> For mmap(), for regular memory, mmap() is always allowed, but faulting
>>> dependsd on shared/private status. It would be nice if the same logic
>>> could apply to guest_memfds that wrap VFIO.
>>>
>>> I prefer the userspace accesses to go through guest_memfd to VFIO so
>>> that the shared/private-ness can be enforced from guest_memfd.
>>>
>>
>> Sure, I can implement this. I guess read(), write(), and ioeventfd will
>> continue to go through the VFIO fd?
>>
>
> If you agree to having mmap() go through guest_memfd, then read() and
> write() should also go through guest_memfd imo. I think it makes sense
> since guest_memfd gates accesses based on shared/private status.
>
> guest_memfd already had plans to support write() [4], so I think
> supporting read() should be fine too.
>
> [4] https://lore.kernel.org/all/20251020161352.69257-1-kalyazin@amazon.com/
>
>
> I'm not super familiar with ioeventfd, let me know if this makes sense:
> ioeventfd is a kind of config, like mmap() is a config, but faulting is
> where the actual access can happen.
>
> guest_memfd always allows mmap(), but only allows faults on shared
> offset ranges.
>
> If userspace sets up some link between a private range and some eventfd,
> I think that's ok, since it's not actually doing accesses. When the
> signalling actually happens, then guest_memfd needs to gate that.
>
> Going by that, I think if the ioeventfd ioctls are just setting up
> links/mapping, then it can go through the VFIO fd.
>
> Between going via the VFIO fd and guest_memfd, I think if "everything is
> wrapped by guest_memfd" a simpler mental model to go with, then maybe we
> could just go with swapping the entire f_ops with guest_memfd's
> intercepted version?
>
>

I omitted the rest of the email so that we can focus on the above. While
implementing mmap redirection through guest_memfd, I found that it
results in code duplication in both the VMM and the kernel. The VMM
already uses the VFIO fd for these operations. I think we should allow
it to continue using the existing flow, with additional checks to ensure
that it accesses only shared regions. Requiring the VMM to use
guest_memfd as the file descriptor for accessing CoCo guest resources
introduces unnecessary duplication.

We cannot move all provider fd ioctls to guest_memfd. Providers may have
different ioctls that access shared regions, and supporting all of them
through guest_memfd would not be practical. VFIO_DEVICE_IOEVENTFD is one
example. If ioctls cannot be moved, the provider code will need access
checks anyway. For example, for VFIO I do:

modified   drivers/vfio/pci/vfio_pci_rdwr.c
@@ -44,7 +44,9 @@ int vfio_pci_core_iowrite##size(struct vfio_pci_core_device *vdev,	\
 {									\
 	if (test_mem) {							\
 		down_read(&vdev->memory_lock);				\
-		if (!__vfio_pci_memory_enabled(vdev)) {			\
+		if (!__vfio_pci_memory_enabled(vdev) ||			\
+		    !vfio_pci_gmem_io_access_allowed(vdev, io,		\
+						     sizeof(u##size))) {	\
 			up_read(&vdev->memory_lock);			\
 			return -EIO;					\
 		}							\
@@ -70,7 +72,9 @@ int vfio_pci_core_ioread##size(struct vfio_pci_core_device *vdev,	\
 {									\
 	if (test_mem) {							\
 		down_read(&vdev->memory_lock);				\
-		if (!__vfio_pci_memory_enabled(vdev)) {			\
+		if (!__vfio_pci_memory_enabled(vdev) ||			\
+		    !vfio_pci_gmem_io_access_allowed(vdev, io,		\
+						     sizeof(u##size))) {	\
 			up_read(&vdev->memory_lock);			\
 			return -EIO;					\
 		}							\
@@ -380,7 +384,10 @@ static int vfio_pci_ioeventfd_handler(void *opaque, void *unused)
 	if (ioeventfd->test_mem) {
 		if (!down_read_trylock(&vdev->memory_lock))
 			return 1; /* Lock contended, use thread */
-		if (!__vfio_pci_memory_enabled(vdev)) {
+		if (!__vfio_pci_memory_enabled(vdev) ||
+		    !vfio_pci_gmem_access_allowed(vdev,
+				VFIO_PCI_INDEX_TO_OFFSET(ioeventfd->bar) +
+				ioeventfd->pos, ioeventfd->count)) {
 			up_read(&vdev->memory_lock);
 			return 0;
 		}


If we are going to do this, it should also be OK to perform the check on
the fault path. For VFIO, that is much simpler.

@@ -1766,6 +1764,14 @@ vm_fault_t vfio_pci_vmf_insert_pfn(struct vfio_pci_core_device *vdev,
 	if (vdev->pm_runtime_engaged || !__vfio_pci_memory_enabled(vdev))
 		return VM_FAULT_SIGBUS;
 
+	/* Check each page separately while guest_memfd controls BAR access. */
+	if (order && vdev->gmem)
+		return VM_FAULT_FALLBACK;
+	/* memory_lock keeps revocation from racing admission and PTE insertion. */
+	if (!vfio_pci_gmem_access_allowed(vdev,
+				(u64)vmf->pgoff << PAGE_SHIFT, PAGE_SIZE))
+		return VM_FAULT_SIGBUS;
+
 	if (!order)
 		return vmf_insert_pfn(vmf->vma, vmf->address, pfn);
 

Given the above, it seems much simpler to allow mmap(), read(), write(),
and ioctls through the VFIO fd. Attach should require
GUEST_MEMFD_FLAG_MMAP, and mmap() on the VFIO fd should be allowed only
when that flag is set.

I can post a series demonstrating the implementation duplication if that
would help.

-aneesh
