Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80DA448F84C
	for <iommu@lists.linux.dev>; Mon, 12 Oct 2026 14:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791816074; cv=pass; b=sTvBYvZnmLdlL/lIO9I0n0d20ek5tlF74eZ6nx9zurs0dSwSCkzClWrgeBIOWQvXCkSw5LLk9e4xLCZxNdAMuTZg9auv9TSbQIeZO00Tpi6aIYwu4/OhIivS4k7suQb1jkkRlOBBRN/agcIthfojFUKaVvJdBqemo6qGVcPFLWA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791816074; c=relaxed/simple;
	bh=EYFNAc3NwLAUZ6w5n0VWHZN4pBcB2B8Fyu8v+g7OFJM=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b+9on46qqxfywlMhu71nKv7npw32i+XlODfOBXJ5BqwT9kIUlFCv6TTSA6VyN7ty7yLeYB6n3t/qesNT79KrKaTeNgnczWmiUKPFbjLlWM4b7LMqFcLqoJAZbPoSASFdaHZUillDcgHb71S8GzpeFPtOayOzkf540u8DjoWWXP0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=blKVVB9A; arc=pass smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="blKVVB9A"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-917a4b69a79so26359506d6.1
        for <iommu@lists.linux.dev>; Mon, 12 Oct 2026 07:41:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791816072; cv=none;
        d=google.com; s=arc-20260327;
        b=AoY0nQ2jAPOmZUoby52koQja14fVK8fqwthcAXJjhLTxNrWdC5FKihBZ/nQMk+fNvt
         05QCDLqHanrd4BjJvoO+uuSKQNZVEb0wtp4fsjhHAMTshAI3pOX00hs7+wzMbGoRvEoF
         15dNTdU3eBJQQ+wK9WL4CT24fjBcdUp4P9RrIFE4WbB6sRixaRDB7asZ7FEXmYDv0O5D
         SgdAKotlTzVaPl1dTaWM3HfP/yQRvxmM7+S8XoYjdDyO6mTXlkwjVdsNH5JObLj1QNO5
         dwQhp1QgL3RlU7v/pWhHVlddziS2k/5G48fYo+bjaFpsQuk4YjXeyk6TG+AtaU8fj7lM
         ytFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=EYFNAc3NwLAUZ6w5n0VWHZN4pBcB2B8Fyu8v+g7OFJM=;
        fh=nnIysCQWB/pkCeOgeeKA6uqEEvcRr37h46um++DgMao=;
        b=EwuvYaMEh3jGdlhTq1uf5nVT1KSddfZNqnD6RjL0Hv+tZLqNa+Y5naZUQGnjypO7Nq
         4easNR9rWOCXdWlcfgyYgfMthav1NiSlo0qCd2vwTzgrvHUzVFMHC7NC+FRi+MqiDQp9
         slD+dfFQPptB4S5nBcLaDe4YYfkdzy8O33OxoD/O2v4f9JfD+6suGFgFDZbDhViJ28Ij
         3lcFFe4hjiHQBMRsHVYF8L8xy5XV/x4hZZYUjAt3OzsNyNbRkUH+2vtFvJHnfljTK87k
         +K7+mrr6bJKdUTHQMUeSTDRhWEiCrlFaemGReoWqab4heDizyW5SguFjZo+swrvLG1Aw
         8uEw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791816072; x=1792420872; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EYFNAc3NwLAUZ6w5n0VWHZN4pBcB2B8Fyu8v+g7OFJM=;
        b=blKVVB9AESUn4kaaRv+A16anbDuhWv31NZV32CO1JVJSUIXEmSQkrwK6DbABdvd3/T
         vGE+MIrcCIzHOwPbHNwG9Cbox+WOxmwzkj46MDpHGuv3FtqfhXeoxazRgthlc3rA5fXV
         6gFgLJLf3L6LT/B2OFyC5R7Wk82PYhAkl6r1lmsSYSetlmHaOqdSvi/9sCilY9cGQ1B3
         jETDmUWH+Ir0woZnZ2uOI5me2cs/Ii5MMG4wRx65r7RXbDOld34GMPEeISfxSWEVAhee
         JGIfx/y3tWcaVvO6VjdFJ1cFxsEeIqZEzAlkp9+m/FO+NYiyDryqdwKmoeXPIqBuDK+E
         9TGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791816072; x=1792420872;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EYFNAc3NwLAUZ6w5n0VWHZN4pBcB2B8Fyu8v+g7OFJM=;
        b=GmPJTwVNjePULXQIm+b0BmEE8/5m8eGKHZ2Yk60sSD98UX7qMJTvtK5GO6t7q9dXcS
         IboSfkf3K0a+xW7VMg7+5ZmaKWFMRts2h5cG+1iyhbwu5tVSkWVZD3j4mG2xUYoshl0P
         l/8aX5E7WkpG/6I4dJWKV1aP0+v5IrpuZWFXxSRHvt+o7iReH2LGVEgQLfYmaIxxbfQd
         f4Vwp+B9bHyFI5pcrDesMuy0qeuCDvy/8UivbeirNsQMAX+W0miYkY65yxIV4Wv3CL5r
         fOnTid5R+N5xsIIJMPM62Uv1Kize3t8c9nZxW9ILUQfkrdStEJ+67qof4tsO7ZHedTAK
         GErQ==
X-Forwarded-Encrypted: i=1; AKwUvByQPdyjUysH/GIWOutj9jDYHwVFefQw1LpqSNAXrNrB9zA3i5OSHuG/Ut9l68eQ9y1AQdv94w==@lists.linux.dev
X-Gm-Message-State: AFq9FYJUV8p7zun0KeMTVlz40oQVbJ3NmGMMz9/ufNdgfy/KhwyzghqB
	gl8PicD4yite0FuDbaQrG6mszAkv96Zra97Q8LR2bJEMHkh1VcjRGjISVyndn7TP31Zb8oG2UHv
	DvcS+MWE2WJ/5ZZ3GrlgaZvt2vpETfFAscx2j+0Gs
X-Gm-Gg: AYBFou2K9U89c37Reqy2bD1lZQfBEO2iaLWNVQV6dtyqRapE5jTk7lno9RGot6PKE6I
	CjvjZL+zQ0xksNwMDWZaJF19y9xIlHw9sXmCluCZx25cNOzdIRDBb6LdRihTe8BmwRAF7xpXoJ7
	xBH4RmtsZQIW2zHL58w/6A3IQXpfPf8w+myuBrnvugGq2M9W/cMOpH0y6+FyosNXrj4KsCRzoRQ
	Q5bXGPILQJhjVlYViI2hlCGx0oHcbRA3qpyPMHWsoPs6YnsKefWs+UVFjDQpSqqDpk49YqXR05f
	IZ290sA9rwjXmz26yJ8CGogSR4B2hJrYDbATbEo5+qnDapbDq5KbZubpK3kRZEnlwtcWv4JaCGB
	FTPiZp5WQ0lUbwJHE+RZ4
X-Received: by 2002:a05:620a:2993:b0:93e:9508:8360 with SMTP id
 af79cd13be357-93ebd1dd868mr1604359685a.27.1791816071132; Mon, 12 Oct 2026
 07:41:11 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 12 Oct 2026 07:41:10 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 12 Oct 2026 07:41:10 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <20261012095800.50250-1-griffoul@gmail.com>
References: <20260720111259.122911-1-dwmw2@infradead.org> <20261006183235.16576-1-griffoul@gmail.com>
 <yq5ald8680t2.fsf@kernel.org> <20261012095800.50250-1-griffoul@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Date: Mon, 12 Oct 2026 07:41:10 -0700
X-Gm-Features: AclHuK-nc_uqkVW8eVTYkrPq_RPqOo6SBs5ABhlJBuD_rVj9OrJECoL16jCBpAc
Message-ID: <CAEvNRgF1hMz+4ivH6WhsEOLTJGOegYO9AYK6OByYysPp_nVJ=g@mail.gmail.com>
Subject: Re: [RFC PATCH 0/9] mm: Memory providers for guest_memfd and iommufd
To: Fred Griffoul <griffoul@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Sean Christopherson <seanjc@google.com>, Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>, 
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H . Peter Anvin" <hpa@zytor.com>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>, 
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, tarunsahu@google.com
Cc: David Woodhouse <dwmw2@infradead.org>, Lorenzo Stoakes <ljs@kernel.org>, 
	"Liam R . Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Joey Gouly <joey.gouly@arm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>, 
	Steffen Eiden <seiden@linux.ibm.com>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	kvmarm@lists.linux.dev, iommu@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Fred Griffoul <griffoul@gmail.com> writes:

> On Sat, Oct 10, 2026, Aneesh Kumar K.V wrote:
>> I have been working on something similar for confidential computing use
>> cases. There is likely some overlap between this series and what I posted
>> at [1].
>>
>> I have not reviewed this series in detail yet, but I will compare the two
>> approaches and identify what can be shared between the use cases. Please
>> let me know how you would like to proceed.
>>
>> [1] https://lore.kernel.org/all/20261010072504.536230-1-aneesh.kumar@kernel.org/
>
> Thanks for the pointer. I read your series, and Ackerley's resource fd
> RFC that it builds on. The use cases differ, but the interfaces overlap,
> and it would be good to agree on the common parts.
>
> All three series add a flag and an fd to KVM_CREATE_GUEST_MEMFD. I
> think one resource_fd is enough, with guest_memfd picking the backend
> from the kind of file it gets. I am happy to drop provider_fd for
> Ackerley's flag and field. We also find the provider from the file in
> three different ways; I would like us to pick one, preferably without
> a registry.
>

David brought up many good points at the LPC discussion, I need to wrap
my head around your model. I'll look closely at Fred and David's
versions this week.

These thoughts are just from reading this email, hope to get more
clarification :)

> The main constraint on our side is that the provider stays the authority
> on which frame backs which page:

Wait, is there some magic done to make struct pages represent different
frames, as in PFNs? In your model, the struct page <=> PFN mapping
doesn't stay constant?

> it moves pages between VMs

Do multiple VMs map the same physical memory at the same time, or is it
a move like below?

I'm thinking that if guest_memfd wraps your provider, then your provider
can issue a revocation to guest_memfd (ctrl-f for
kvm_gmem_provider_revoke in [1]) on the move source guest_memfd inode,
then wait for an allocation request from the move target guest_memfd
inode.

[1] https://lpc.events/event/20/contributions/2551/attachments/2047/4693/lpc-2026-gmem-other-backends.pdf

> and has to
> survive a live update.

guest_memfd is going to support preservation [2]. Tarun's series just
preserves memory from guest_memfd's default provider (buddy allocator)
now. For your provider, I imagine the preservation flow would preserve
whatever metadata in guest_memfd (like the attributes in the maple tree)
and then go on to notify the provider to preserve some range of PFNs (or
folios). Your provider would then basically do nothing, since those PFNs
already survive a live update.

[2] https://lore.kernel.org/all/20260728121138.1103610-1-tarunsahu@google.com/

> What would not work for us is guest_memfd
> becoming the primary manager of PFN memory, as Ackerley suggests. Your
> get_pfn() leaves VFIO as the authority for the BAR, so I think we agree
> there.
>
> You refuse dma-buf exports while guest_memfd is attached. That is
> roughly what the memory provider interface is for: one owner, several
> users, and one revoke that reaches all of them. A BAR exposed as a
> provider file could be mapped by both guest_memfd and iommufd.
>

Will read the rest of this series and reply again :)

> I plan to change the revoke anyway, because iommufd must not leave the
> device with a hole: it should replace mappings in place instead of
> unmapping and remapping. Would that fit your case? I suspect it depends
> on locking, for example whether you have to revoke while holding
> memory_lock.
>
> Shared/private state and the conversion hooks would stay in
> guest_memfd and the arch code, as in your series.
>
> Does that sound reasonable? Ackerley, David, any thoughts?
>
> Thanks,
> Fred
