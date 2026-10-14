Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96F3B4FECFB
	for <iommu@lists.linux.dev>; Wed, 14 Oct 2026 19:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792007621; cv=pass; b=JmaZghE/s32OcTgOpDbE06MG+cZ+8QFRk/qWlBo6oXBrtWuWzRoQFNbbNa3b/j1gHjULeLG8aZBmszcsMupJgSMx8oD4//j6vh+gK5v1otnnc/+mj0VAwrSwLzSvvYMf2QnKdiP2oRThsjqnfokL66Nda0x/OHMBbPetn8SGXjY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792007621; c=relaxed/simple;
	bh=b3ueYwo9fjE03GJnGTWoxYYbVKoqoGXBaT55QOht5OU=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VTv2JbWlYTstSUHz8Zo84GuTGPt8HCB/K+PWoIOt1XT7SKWCg/Dht04chsr5+qVozBM3SUKXHdJIm4LjKRhaY1R36hfzOKHjl/W7yr35JMM9S+N+dD5X5gJPvdZnyJlH+XrpqKeruQ9yDTJaQ47PkcGm2CxjEuSiKZVdCbgFYe0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vYLtKyDU; arc=pass smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vYLtKyDU"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-93e762768f3so503042385a.0
        for <iommu@lists.linux.dev>; Wed, 14 Oct 2026 12:53:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792007618; cv=none;
        d=google.com; s=arc-20260327;
        b=Za8JxNBPh1InCgOQR7djdPlSe7ROH3woTc5JAL0unbv9RiRDgYE7zvJj9bTJoeCTzQ
         VjGKIVm5C+CfD6ToKtECid+WPN95UQtA8Lkq0QjDAUDU4GXXlDDVnHXuAVvy1O/9xeHa
         pOs/soyfF40lK5SSW16PwnAP+wqzeSkQR6xj2TR1vFeqI7LJkngmj2XO+5s2PONjU8Rl
         Px8RIgSnCYRd2Jd601JSOX4ylmDfM4EKjT7r1rgXeAGmbZzqRPS5rl9q5yWb2MTca9RI
         tAxoPcc/HOrjCAYKSYrfuJamuKsyKEbxtfDFrnNrFKiOQTALLTlkUV9YRIZfSvDeTpqt
         3Irg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=b3ueYwo9fjE03GJnGTWoxYYbVKoqoGXBaT55QOht5OU=;
        fh=LoHuJ6uAg8sbdaqPmI1sKOA53AHaiodiZQRguqO+BUY=;
        b=KV3sgkLjkEIpXOugAZCSys/RAcgsNv1259TjLc9VjoAFXW3GqIYJuOMtVxgT8NwVzt
         hEOwDjXxCZIzHglIOudL7F2bxktWjjUHKgTqWhWw4QW4UclNkl70Ai6szFnU/UB9QsOy
         kP5TgNu9hFd8GiX2BE4G/mdK+hY8Avs/ZzkJnyMPFkgg5VEWhoXryPkvLeG7iLl+TIy6
         D88fKlQq+lrCKjX1DNF2KKy6cwspEQA052e9HFnhGa5RXFmJNqFZiLzF5hBQvP9yknUg
         leFNAdZZAk2PKcUTjK22S54MHFsrOMf3i3hdsxrECjw7qTLtoGFcaG+nIVuIfb/8xePS
         oV2w==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792007618; x=1792612418; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=b3ueYwo9fjE03GJnGTWoxYYbVKoqoGXBaT55QOht5OU=;
        b=vYLtKyDUEtqub0r7xU8xmogA9Yv399QlK33KQ68E7S02tos5/7u6n2WCKAGd/E/nhn
         +7Jz+POkmoTDudgNxnXJk2mYVusC6/Izqkx1qVQNAMh0p+WujlWCY3pep1LW/3wjJEkC
         Sfq1XPoZRylCzixWJt3aamm6ghFy9u3Ddn4qpRHOOFQrqadE4XmCPHI5vPtG2UVT1/aw
         QJYp5oO7kTO4La8EDDe2RvqH7/gqvpKu+j+sAAUmMX3F7LDSDRHWr9N+SOGhKGnD9K1a
         F6B4f7oSm8NMS1GpbS1hethjK2+PgO6EJDuYb6FyXECEoih7D0adF1KPyoi4GExfsHGQ
         GAQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792007618; x=1792612418;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=b3ueYwo9fjE03GJnGTWoxYYbVKoqoGXBaT55QOht5OU=;
        b=KFIp4eJz7L+mWKrcs9kM7NN4MlvTjuNkKF3jj0olmu5DBJcbM0S4P6G4Ga2cfveuiK
         SLK2UzhLi+5FzLmj74+qKLkYs8RzJPNeZ4V2gnpXQCWSLkAKAmvcGR/EXIvnZ8PwcN/E
         T0sCrD/Y9d0wEEUVaqqITw/2qXZ43K0sE3NR1gNFCn3qIZmdicEkmNW9IEorEoSrtdMF
         kgE90ckvdgLOGa38qLoomr82AfARrYfI1RL+FmCkFO/6g59gWGp1WwroiStm4myQlB8m
         Ak6igPnqwRq2nK1zX3bZLfkNAG+er3ojznmzTT8NaZuQQvVXTmcFqQjpGBy596kdpBB4
         ArbA==
X-Forwarded-Encrypted: i=1; AKwUvBzNlt+6rbAMEaWl7UIaOA6EStX92jCoemsVEXDFDayC7Boqw0HTQ8X/KikqqkfFbKxKqkFOZA==@lists.linux.dev
X-Gm-Message-State: AFq9FYJCTGSl4AbCL36iuCfJxX3iVIDtHLrRJnzIxrSqnhvbhGylHG1i
	REOz86xC30niV+Eyq6gReRAC5qGDCfAjDzfynQeXkkA8R5B9439fgKSaKEl8Pc4+ZJUmY7TNtuq
	vBTnVIOwXm/YCTL7owqr4N3ENfSk9ryO6q3UYOh2l
X-Gm-Gg: AYBFou1EK+9XFleLMHIRW8gdCZHSwUcAKChikey2MIHDUHIbl8ppTr9ZIw/JaaQ/n97
	wMS+6TBVDN6al2ZlI1tLWVXeJM+ELeEShZgB5mRR6dxxq4Q8zqjSH2LV6rv8XIjuE45dBKSnk4U
	yrsoIwg57zm/J45+Pcf9zRaz6G95B3Sv/l/OVko5Xcr4tXgKjovOzjBjGDSr1tsKJwk0ypH3gP4
	1EqFW16Xg7ebn4nW7xDroeANnJNcxU4gyse2EXnv0HCNwVklI2Db3dVxByTpfh7GrcflYhZC9Rd
	HFWww8HdteMA3I9cmm+Xbux7Pp7ZJM3CZ4ZdAaTCoI0czpW4eLOVAT20xVfk8Vu4xzPSpXvsOB6
	j4r30uuHXGRw1Wn9GnGg9L/L6z5NRq3gHwLRkU2CJ11s=
X-Received: by 2002:a05:620a:a2cf:10b0:93e:c12c:f142 with SMTP id
 af79cd13be357-93ec12d0865mr1898747285a.76.1792007617714; Wed, 14 Oct 2026
 12:53:37 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 14 Oct 2026 12:53:36 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 14 Oct 2026 12:53:36 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <yq5a7bjky8wj.fsf@kernel.org>
References: <20261010072504.536230-1-aneesh.kumar@kernel.org>
 <CAEvNRgFC6U4er0QhcwVOqWyz657WWWtidkNu0hKS5go4A3cP4g@mail.gmail.com> <yq5a7bjky8wj.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Date: Wed, 14 Oct 2026 12:53:36 -0700
X-Gm-Features: AclHuK-WbMkUylbHFNMeinh59E-dHthPA1VhGiwdfTYkoCCF9XbdzoNbemMEawg
Message-ID: <CAEvNRgGfjHhVCxHhew8AMKhXrX6XDrbrw5zpQM9LaODhJHRYYg@mail.gmail.com>
Subject: Re: [RFC PATCH v1 0/6] KVM/VFIO: guest_memfd support for device MMIO resources
To: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, linux-coco@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Cc: Alex Williamson <alex@shazbot.org>, David Woodhouse <dwmw2@infradead.org>, 
	David Hildenbrand <david@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, "Joerg Roedel (AMD)" <joro@8bytes.org>, 
	Kevin Tian <kevin.tian@intel.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Robin Murphy <robin.murphy@arm.com>, Sean Christopherson <seanjc@google.com>, Will Deacon <will@kernel.org>, 
	Alexey Kardashevskiy <aik@amd.com>, Xu Yilun <yilun.xu@linux.intel.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Steven Price <steven.price@arm.com>, Fred Griffoul <griffoul@gmail.com>, iommu@lists.linux.dev, 
	kvm@vger.kernel.org, john.starks@microsoft.com, jacob.pan@linux.microsoft.com, 
	gourry@gourry.net, vannapurve@google.com, fvdl@google.com, tabba@google.com, 
	dave.jiang@intel.com
Content-Type: text/plain; charset="UTF-8"

Aneesh Kumar K.V <aneesh.kumar@kernel.org> writes:

> Ackerley Tng <ackerleytng@google.com> writes:
>
>> "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org> writes:
>>
>>> This series adds a guest_memfd device-resource framework for exposing PCI
>>> BAR memory to guests. The intended use is confidential device assignment,
>>> where KVM needs to coordinate private device mappings with shared access
>>> through VFIO. The Arm CCA backend is provided separately; these patches
>>> contain the guest_memfd, VFIO and IOMMUFD interfaces it uses.
>>>
>>
>> Thank you Aneesh!
>>
>> I definitely like this since it builds upon [1], the model where
>> guest_memfd coordinates zapping during conversions for the
>> provider. Please see comparison with the alternative at [2].
>>
>>>
>>> [...snip...]
>>>
>>
>> I have questions:
>>
>>> Userspace creates a device-backed guest_memfd using the ordinary VFIO
>>> device fd as resource_fd, with GUEST_MEMFD_FLAG_USE_RESOURCE,
>>> GUEST_MEMFD_FLAG_DEVICE
>>
>> With the model described at [1][2][3], I was thinking that the VFIO fd
>> would be the resource fd. I'm hoping that there wouldn't be a need for
>> GUEST_MEMFD_FLAG_DEVICE.
>>
>> The plan [3] was for resource fd to represent just the resource but not
>> provide any way to access the underlying resource, so that after
>> .attach(), guest_memfd's fd should be the way userspace would access the
>> underlying resource.
>>
>> For tmpfs, the example in [1], fsmount() returns an fd that has no
>> .mmap/.read/.write ops, which fits the plan above perfectly. It tells
>> guest_memfd about the resource, but does not give userspace access to
>> the resource.
>>
>> In VFIO's case, vfio_device_fops does implement .mmap()/.read/.write,
>> and I don't think there's a better existing fd that represents a single
>> device.
>>
>
> With VFIO, after attachment we can reject new mmap() calls by checking
> the attachment status in vfio_pci_core_mmap(). During attachment, we can
> reject the operation if the VFIO fd already has an mmap. But I guess
> read(), write(), and VFIO_DEVICE_IOEVENTFD should still operate through
> the VFIO fd, or are you suggesting that all of them operate through
> guest_memfd?
>
> I am not sure we want to move the ioeventfd ioctl out of VFIO. If it
> remains there, userspace needs write access to shared BAR regions via
> vfio fd, so it would make sense to continue allowing read() and write()
> as well. If we allow read() and write(), should we also allow mmap()?
>
> I agree that keeping userspace mappings(mmap) under guest_memfd rather
> than VFIO simplifies conversion. The conversion then becomes:
>
> unmap_mapping_pages(inode->i_mapping, start, nr_pages, true); //unmap user mapping
> kvm_gmem_invalidate_start(inode, start, start + nr_pages, KVM_FILTER_SHARED); // stage2 unmap
>
>
> Both are now under guest_memfd control, so no VFIO callback is needed.
>

+1, yes!

>>
>>> and GUEST_MEMFD_FLAG_INIT_SHARED. Eligible BAR
>>> intervals are registered as guest_memfd memslots. File offsets use the
>>> existing VFIO region-offset namespace, allowing one guest_memfd to cover
>>> multiple BAR intervals. Device-backed guest_memfd rejects mmap and
>>> fallocate; shared guest faults obtain bare BAR PFNs from the provider
>>> instead of resolving the memslot HVA or allocating folios.
>>>
>>
>> The model I have in mind is kind of opposite from above. Instead of the
>> guest_memfd rejecting mmap(), I'm thinking that the VFIO fd should be
>> the one that rejects mmap(), read() and write() once guest_memfd
>> attaches to it.
>>
>> If userspace needed to mmap() the VFIO fd, it should instead mmap() the
>> guest_memfd fd. guest_memfd doesn't support read() and write() now, but
>> support can be added. The read/write for guest_memfd just forwards to
>> vfio if the offset range is shared and blocks if the range is
>> private.
>>
>> For mmap(), for regular memory, mmap() is always allowed, but faulting
>> dependsd on shared/private status. It would be nice if the same logic
>> could apply to guest_memfds that wrap VFIO.
>>
>> I prefer the userspace accesses to go through guest_memfd to VFIO so
>> that the shared/private-ness can be enforced from guest_memfd.
>>
>
> Sure, I can implement this. I guess read(), write(), and ioeventfd will
> continue to go through the VFIO fd?
>

If you agree to having mmap() go through guest_memfd, then read() and
write() should also go through guest_memfd imo. I think it makes sense
since guest_memfd gates accesses based on shared/private status.

guest_memfd already had plans to support write() [4], so I think
supporting read() should be fine too.

[4] https://lore.kernel.org/all/20251020161352.69257-1-kalyazin@amazon.com/


I'm not super familiar with ioeventfd, let me know if this makes sense:
ioeventfd is a kind of config, like mmap() is a config, but faulting is
where the actual access can happen.

guest_memfd always allows mmap(), but only allows faults on shared
offset ranges.

If userspace sets up some link between a private range and some eventfd,
I think that's ok, since it's not actually doing accesses. When the
signalling actually happens, then guest_memfd needs to gate that.

Going by that, I think if the ioeventfd ioctls are just setting up
links/mapping, then it can go through the VFIO fd.

Between going via the VFIO fd and guest_memfd, I think if "everything is
wrapped by guest_memfd" a simpler mental model to go with, then maybe we
could just go with swapping the entire f_ops with guest_memfd's
intercepted version?


IIUC during the LPC discussion some people were suggesting creating a
brand-new only-for-guest-memfd resource fd and not relying on existing
mount fds or VFIO fds. What do you think of that? Instead of using the
existing VFIO fd, would it be better to create a new for-gmem-to-wrap
VFIO fd? I didn't like the idea of needing to create a new kind of fd
for every resource guest_memfd needs to wrap.

>>
>>
>> Is GUEST_MEMFD_FLAG_DEVICE there because GUEST_MEMFD_FLAG_USE_RESOURCE
>> tells guest_memfd to look up
>> resource_inode->i_sb->s_op->gmem_provider_ops but for VFIO,
>> gmem_provider_ops can't be stored in super_operations? If that's the
>> only reason, that's a very good reason to store gmem_provider_ops in
>> file_operations for gmem_provider_ops to serve different kinds resources
>> and include VFIO.
>>
>
> I can use the same approach for VFIO. I kept the current implementation
> simpler by using a registration framework on the VFIO side.
>
> I can switch to gmem_provider_ops if we are comfortable adding the
> device-specific callbacks to guest_memfd_provider_operations. Since the

Yes please, gmem_provider_ops in my RFC was just a minimal set, we can
expand that as providers require.

Imo we should have either gmem_provider_ops in some ops
(super_operations or file_operations or elsewhere), or a registration
model for all of gmem_provider_ops, but not a mixture of global vs
registration.

> VFIO core supports multiple backend drivers, such as vfio-pci, the
> superblock operations would essentially forward the calls to the
> appropriate backend driver. That is a VFIO-specific detail that
> guest_memfd can ignore.
>
>>
>> I also noticed the need to guest_memfd_register_device_fops, so that
>> guest_memfd knows the device supports being attached to?
>>
>> What do you think of this: we have a common attach function for all VFIO
>> fds in file_operations that would look up the struct vfio_device to
>> determine if guest_memfd can attach to the vfio device? Actually, which
>> devices would not support attaching? Wouldn't all devices support
>> attaching? I'm thinking that using a device that is all-shared via
>> guest_memfd should be no different from using the device directly. All
>> operations should flow through to the device.
>>
>
>>
>> Regarding conversions, I would like to check: with Confidential IO, are
>> conversions at runtime actually necessary?
>>
>
> They occur at runtime after the guest starts, but are infrequent. The
> entire region starts shared. The guest validates the interface report and
> requests that the BAR regions be mapped private. They remain private until
> the host converts them back to shared during the TDISP unlock operation.
>

I see, so infrequent == once ever? Could the guest want to, at runtime,
switch some BARs between shared/private? I wonder if the spec supports
runtime conversions.

>>
>> Is the only "conversion" the one when the guest accepts a device? If so,
>> maybe that "conversion" can be implemented by replacing memslots.
>>
>> Pre-accept, mmap() the vfio fd directly, set it up in memslots.
>>
>> Post-accept, remove the old memslot, wrap the vfio fd with guest_memfd,
>> set up the guest_memfd statically with shared/private ranges as the TDI
>> report requested and never allow conversions, replace the pre-accept
>> memslot.
>>
>
> Is there a reason to use two different flows here? Why can't we always
> use guest_memfd?

I was hoping blocking conversion could make the implementation simpler
if we never need to convert at runtime. It might be easier to merge if
we trim the features. :) It's also nice to have consistency with regular
guest RAM though.

> We could attach the device at startup and use
> guest_memfd before acceptance, while the BAR is mapped shared. We would
> not need mmap() unless userspace requires it for another reason; the VM
> fault handler could fault in those PFNs.
>

Did you mean to just block mmap() access completely from userspace on a
gmem-wrapped-vfio-fd?

If the CoCo guest and device allows some BAR to be shared, I was
assuming that's because the host might need to take some action on those
ranges. If so, then mmap() would be one way to access those ranges (in
addition to read()/write()). I think we should still support faulting
into userspace page tables for shared ranges from a
gmem-wrapped-vfio-fd, and ideally follow the same model as regular
guest_memfd where mmap() is always allowed, but not faulting for
CoCo-private offset ranges.

> During device acceptance, we convert those BARs to private. On CCA, we
> also create the stage2 mappings at that point, since private BAR regions
> do not support fault handling.
>

I see, thanks for explaining! This is one thing different private BARs,
that private BARs cannot be faulted into stage 2 at runtime.

With Confidential IO, private BARs don't support fault handling, do
shared BARs support fault handling?

>>
>>> IOMMUFD resolves and pins the device's existing vDEVICE for the VM and
>>> serializes MMIO conversion through its MMIO mutex. VFIO supplies BAR PFNs,
>>> checks eligible ranges and excludes independent dma-buf exports while a

Thanks for excluding dma-buf exports, this is important, we can't let
dma-buf exports be a backdoor to access guest-private memory.

>>> guest_memfd provider is attached. VFIO host mmap faults, read/write and
>>> ioeventfd accesses check the requested range's guest_memfd attributes.
>>> Conversion revokes cached host mappings and shared guest mappings before
>>> installing private mappings. Other shared intervals remain accessible.
>>>
>>>
>>> [...snip...]
>>>
>>
>> [1] https://lore.kernel.org/all/20260925-gmem-tmpfs-backend-v1-0-d36159822d18@google.com/
>> [2] https://lore.kernel.org/all/CAEvNRgEseLO+LbkwXrEit0H2LH5Wx-srSvHEMpt0=upPL3tF=g@mail.gmail.com/
>> [3] https://lpc.events/event/20/contributions/2551/attachments/2047/4693/lpc-2026-gmem-other-backends.pdf
>
> -aneesh
