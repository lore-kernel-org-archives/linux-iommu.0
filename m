Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CDF5542EEB
	for <iommu@lists.linux.dev>; Tue, 13 Oct 2026 19:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791921245; cv=pass; b=F4E1v561tplpQgloFheuMi4k0Gye08T5mLvzVXVJcXpgH6GAlCY5NhU8B4i3IJL+/IkDY29usbt+bDF0k4nBrq+peDzs7luWy1VTdzarAS9LkNunCPfcG5pP8l0+tir1a4ScGNK+5tkHGzQtMRk+pUHWo7Q5mlFr7eYVp9aCU4k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791921245; c=relaxed/simple;
	bh=gz/rGOEvzA8Irn4bo3jjQQgOvzTDOAdHYh6h6XK0A+I=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QHEcFKG3XiSfA8QOVNWFBgRGuoNdR6ndtoR0csQX5DalmHQniwBrTRvWe/chFeXKIQp6t76EZGJA+3hvtnR5qpgGMkC6JswOoJ6H/mlg6Jth5vBoza5YMm33Vvfr/coLM++gNL/e+pvqN8FSmfZV2RYesne9ryzmCZ5cVbzMqWw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=O8/1r82C; arc=pass smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="O8/1r82C"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-917c04630c2so43992066d6.3
        for <iommu@lists.linux.dev>; Tue, 13 Oct 2026 12:54:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791921242; cv=none;
        d=google.com; s=arc-20260327;
        b=mHsjHIFlxVT7jjN/xbmJ3RiVMU1lLEKuINO/fnlYZ9urI6WyOKZaqEHKtr9EWU4pYz
         c3o0SHavLnp661aYAFjApgH2/P+9XmUArCqpdQ6+ymiN9i7EDr/VV3zRjR+oYNzGdfLK
         HqyFycQTKURvgekfNQEc1hra3YIRjictAOs6Kb4T/Dr2GkiGTLILk5B3lXZPi7OkQu5G
         KBGFe1P21sZx9/Y2m76iWwhAmXGdVEI23yl9rTx0I/gVFAkhEnFlA1FSLDxpsyUU9LZL
         73K0l2qC9pPtVl81zoMEq9RsrVsU+nmsC3BaHfCMoKwXMweInFwyJSATXHnJAw3TNyxT
         OffQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=fjiIk8S/1b/fq42ObdZjHlUOMsEJstLh+gvZY/xKhZA=;
        fh=pCQ52PiWGUGKLIlwCkM7Ra0fvdyolF68EeM10jmZx+8=;
        b=fuzTPsngK2H3tBBV5pTyLVeJrU4vHNRF+ws8qXGzJQsSs6HMXC2/V8xE7fIQM1C7/9
         aZNAPAKMnpPuKzHbbM751n/LuGHnrHpLcYkIx35hKuD90Cc6wKMe54+pE13DssAui9Vp
         3jopIhPJ+tuzOIAwhYDoxZUQTC0o7NoIExvrTOI5qnuh2uCrJVH8ypa4y9Jy/97JlB+p
         0hlYkDil6UjpQJxXClYWwgyjh4wGCzufR4VmISo12CtDu5FLufW5H7zPNQ831rKn7nle
         RV/oZRGDS+Yux6PXqGZQ7r6rgfMudqUOzYa5rsnQyYQ/bdVMCNKyQ1iG+T0+OUB2KZwe
         u5Vg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791921242; x=1792526042; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fjiIk8S/1b/fq42ObdZjHlUOMsEJstLh+gvZY/xKhZA=;
        b=O8/1r82CTOIxXhQQU/eZGx6PTWWA5fVrf1SivY4nm+QGU3XxdXR2wpsZDeejBcqUnr
         GqQnPP5YbtVLcCfUz6nisrcH9CHVa4abrUWTrMDuMqvDBrB+/yfWXHNVs1k5ge+E+x5m
         Izq3htxD9kI3+GSzKmprztUqg/Oe9EKDXyW9ZhHlQ94xeiIByrFntsWE8lJG11dR3w62
         VIMeACcB9Rw8nJsqbkXzq5UNSkQvN3gF340f1pbV8vxcnoK86s0t542YX6dOAf4GXUTP
         OJi6wnMjd0pRZnmz/wXtt1Xix13gjr3ShKQT7L8GECiyXKh2sma6Ipt0S4k3rrwBO3VV
         tlIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791921242; x=1792526042;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fjiIk8S/1b/fq42ObdZjHlUOMsEJstLh+gvZY/xKhZA=;
        b=df4HLrR4WcwgQqqHWDce8Iw42cCMvWMHovxd9KAUTJPjowo2h0mMNfZqYlEuMh/76n
         yO+K9fNqnLk0DUjBLLgAzBZWlQunEUOv+2NDvigyFvDSoLEYb6fsSwBo1okAfVP11V5y
         Ece535lRBJHfFvcic0lPaHxAbztgxKIMFTsxIvvBfQVsJskI/CEJ6rsgQx+favAbjYIh
         AGkDvenYMtcB2CYG3ioenrL/R0YJDyDHQSi0jORR69PrYM9hffHYgkMSSLmdeYuNPgie
         AmZw3Gd+XqePaNIlrgzi8BL9UHO1jTH9Ij/NUYWVQmf2BkuVz2IxLBx+sRjXx82nTUqf
         +MCQ==
X-Forwarded-Encrypted: i=1; AKwUvBxOo4eNJ7pdMg4wN5A8ZHy8VHQH+NA8oMLxBziddMamSQLbt6EbBnwDl+zE5wlgQA7Cf09Jbg==@lists.linux.dev
X-Gm-Message-State: AFq9FYIJyYcf3rCFo9OZiE1ECGLkjzRh4Uo4z4SHICN98oekr2VAKBsc
	f/I3XDGPjb7BKiEPS0uAEWecq+rm68QP1vvgtq3ue7urWk2AkZ4LFHFbvk0dtMZrbW215qHBqFe
	CNudvx/+JzX2hsAxZXxFAQ08ixom/I99GCrKzIljm
X-Gm-Gg: AYBFou1ZlgtPXRkWNDbIWNoo8Ydy5QkRr2yy7skWzKNgi1qiGvld0yTxHfhpjWV3bs7
	nksVmMwy3CIpWGEDAu5Qc+vwYcozL5035tjtggZKZMpsDr9oAjB30XjDzEGaIj2ItoS/hXrKXht
	i93xmmtwzWVSBv2sSfy4wSFVdA7SwwIuCnsM1jCfG32S+Zp76DmYvy3yvHHuMjo0e/kbx7Gfc12
	r45KCnapLDlaPvAtQN14OXIdOYS3sfngYQfMfAN3E3N7pyvnotdLzaamr9gAVQ+SLc/tJTyTQ1Y
	IlLGFqab8XiWRYokgy84WWYeJhD+chmIvCHhKvusMwnAWgola13pukNl4rJ8bLHdthdgegab/Ji
	fwhk78DPPkjR+OwCe8ewnE+7zlPaCcfEt56Edowxrrw==
X-Received: by 2002:a05:6214:5085:b0:90c:b843:d679 with SMTP id
 6a1803df08f44-91b555668b1mr241693526d6.29.1791921240685; Tue, 13 Oct 2026
 12:54:00 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 13 Oct 2026 12:53:59 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 13 Oct 2026 12:53:59 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <20261006183235.16576-1-griffoul@gmail.com>
References: <20260720111259.122911-1-dwmw2@infradead.org> <20261006183235.16576-1-griffoul@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Date: Tue, 13 Oct 2026 12:53:59 -0700
X-Gm-Features: AclHuK8TQPboa9RVDrBS_-w6dTXGHf21nXTRvYl_CuU35T-tn195uLjZFRceV3k
Message-ID: <CAEvNRgEseLO+LbkwXrEit0H2LH5Wx-srSvHEMpt0=upPL3tF=g@mail.gmail.com>
Subject: Re: [RFC PATCH 0/9] mm: Memory providers for guest_memfd and iommufd
To: Fred Griffoul <griffoul@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Sean Christopherson <seanjc@google.com>, Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>, 
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H . Peter Anvin" <hpa@zytor.com>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>
Cc: David Woodhouse <dwmw2@infradead.org>, Lorenzo Stoakes <ljs@kernel.org>, 
	"Liam R . Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Joey Gouly <joey.gouly@arm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>, 
	Steffen Eiden <seiden@linux.ibm.com>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	kvmarm@lists.linux.dev, iommu@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, linux-kselftest@vger.kernel.org, aik@amd.com, 
	jacob.pan@linux.microsoft.com, gourry@gourry.net, vannapurve@google.com, 
	fvdl@google.com, tabba@google.com, dave.jiang@intel.com, 
	aneesh.kumar@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hey David/Fred,

I took some time to read the patches, hope I got everything :) The
biggest difference between your approach and mine is who (provider or
guest_memfd) manages the zapping across all the users.

The memory users here are

1. [KVM] The guest (KVM manages the stage 2 page tables)
2. [IOMMU] The IOMMU (iommufd manages the stage 2 page tables)
3. [USERSPACE] Host userspace (guest_memfd handles faults, I guess you
   could say core mm manages host userspace page tables)
4. [DIRECTMAP] Kernel direct map. Your provider already provides PFNs
   that are presumably not in the direct map. For other providers, the
   direct map is another mapping that may need to be zapped on
   private/shared conversions. (Listing this here for completeness, I
   think this should be tackled separately.)

I'll use [LABEL] to illustrate the way notifications flow in your
approach vs mine.

When the provider wants to revoke the page, the notifications/function
calls flow this way, the last [ENTITY] in the chain actually does the
zapping.

+ [PROVIDER] -> [KVM]
+ [PROVIDER] -> [DMABUF] -> [IOMMU]
+ [PROVIDER] -> [GUEST_MEMFD] -> [USERSPACE] (AFAICT this was not
  implemented in the RFC.)

That's when the provider wants to revoke the page. IIUC guest_memfd
conversions was not illustrated in the RFC: what happens on a shared
-> private conversion?

+ [KVM]: Zap only shared pages, keep private pages mapped.
+ [IOMMU]:
    + Before Confidential IO: so far, IOMMU mappings are mapped
      indirectly via [USERSPACE] mappings. guest_memfd zaps
      [USERSPACE] mappings, then checks refcounts to ensure no other
      mappings (which includes IOMMU). See __kvm_gmem_set_attributes()
      on kvm-x86/coco [2].
    + With Confidential IO: shared IOMMU mapping need to be zapped,
      keep mappings of private pages.
+ [USERSPACE]: Zap all mappings on shared->private conversions.
+ [DIRECTMAP]: Can zap these mappings (not implemented yet, but
  discussed in the context of Direct Map Removal support for
  guest_memfd [3])

To have the conversions work, in your model, we'd need to do

+ [GUEST_MEMFD] -> [PROVIDER] -> [KVM] (zap only shared pages)
+ [GUEST_MEMFD] -> [PROVIDER] -> [DMABUF] -> [IOMMU] (zap only shared pages)
+ [GUEST_MEMFD] -> [USERSPACE] (IIUC the provider doesn't directly
  allow mapping to userspace, also in your approach the provider
  pretty much replaces all the innards of guest_memfd anyway, hence
  I'm showing this as gmem going direct to zap userspace)

With my proposal [1], we could do

+ [GUEST_MEMFD] -> [KVM] (zap only shared pages, implemented in [2])
+ [GUEST_MEMFD] -> [IOMMU] (zap only shared pages)
+ [GUEST_MEMFD] -> [USERSPACE] (implemented in [2])
+ [GUEST_MEMFD] -> [DIRECTMAP] (future)

In my proposal, I agree with you completely that the provider must be
allowed to revoke memory. Using the sample in this RFC, gmem_fd_ioctl()
called with !GMEM_PROVIDER_SET_PRESENT is where the provider wants to
revoke memory, and the revocation in my model would look like

  [PROVIDER] -> [GUEST_MEMFD]

and [GUEST_MEMFD] would then fan it out to [KVM], [IOMMU], [USERSPACE]
and [DIRECTMAP].

The [GUEST_MEMFD] -> [IOMMU] is missing from my proposal because I was
seeing that as a separate patch series. I think what we want is to have
IOMMU_IOAS_MAP_FILE be able to accept a guest_memfd file. Currently,
during the mapping process(), memfd_pin_folios() is used, which has this
check

	if (!shmem_file(memfd) && !is_file_hugepages(memfd))
		return -EINVAL;

that disqualifies guest_memfd. Refcounting won't work for guest_memfd()
folios because of conversions (see kvm_gmem_has_outstanding_references
at [4]). The implementation I have in mind is to have the the iommufd
instance be tracked in guest_memfd during the pinning process, and
that's the pointer guest_memfd will use to get iommufd to zap during
[GUEST_MEMFD] -> [IOMMU]. This [GUEST_MEMFD] -> [IOMMU] zapping was
previously also proposed in the context of Confidential IO [5].

[1] https://lore.kernel.org/all/20260925-gmem-tmpfs-backend-v1-0-d36159822d18@google.com/
[2] https://github.com/kvm-x86/linux/blob/a6270ed4bec0caa25913082e71ce22254e9cd3ed/virt/kvm/guest_memfd.c#L685
[3] https://lore.kernel.org/all/20260410151746.61150-1-kalyazin@amazon.com/
[4] https://github.com/kvm-x86/linux/blob/a6270ed4bec0caa25913082e71ce22254e9cd3ed/virt/kvm/guest_memfd.c#L722
[5] https://lore.kernel.org/all/20260225075211.3353194-1-aik@amd.com/

I'm intentionally avoiding the "primary manager" terminology since
that's overly broad and doesn't really explain what processes exactly
are being managed. It's really just which entity tells which other
entity to zap pages, and since shared/private-ness of memory is core to
guest_memfd, I think guest_memfd is in the best position to tell all the
other entities to zap, and what (shared/private to zap).

Does your provider need to know if some memory was transitioned between
shared/private states? The provider can be notified too, if
necessary. If not, then isn't guest_memfd doing all the coordination
better than going via the provider?

Does the revocation model work for you? If it helps, I can rebuild the
sample provider to illustrate how the revocation can be done. Let me
know what else is missing from my model [1]. :)
