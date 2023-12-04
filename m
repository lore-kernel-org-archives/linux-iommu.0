Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C208C2EB0E
	for <iommu@lists.linux.dev>; Mon,  4 Dec 2023 19:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eloR/Shs"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-1d09caea9e3so8438205ad.1
        for <iommu@lists.linux.dev>; Mon, 04 Dec 2023 11:22:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701717771; x=1702322571; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=rzYon50ijdZ64vLfYd4avKup56gTUfCE1fyLL3+Ev1w=;
        b=eloR/ShswTmguEpe1HBTU+sqJe2+nWzx03wWjkZLFSbwzLb5Bbs+2/QrQD5IAqFhQJ
         BdjbhMBkhYmWu+o5dfEyRTskSwqnY2tS1cCnuEYmVJQjvkQP6+jP9DE2UqnZ6WKLkr26
         X1wUZXTF+fhoKRYyemWPyRhFw4UjRNhQW2di91wb6gT8ljRlXBvi3QF5VJcwyAwDLad8
         OSIuKuirK64LUzFv1omarUJjdtfi4Ifqu/BWB+c2oJp+3p2Y2h4Ky+uziuQ9q7JXnXLN
         MObA6+UrRnJiEDjXD4dbgHo9mhgpR/W1CEuTJvYforFPogGCFMWr5mxN8EmRJnSmqV8M
         POYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701717771; x=1702322571;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rzYon50ijdZ64vLfYd4avKup56gTUfCE1fyLL3+Ev1w=;
        b=aYGnYyo7ft8mWZBbWGo2C2wn73XMSssjPNAIPpO08J/25E/AI2k6R9JROlzfD0Dyq2
         s+xL04se7DUJ06nti1I5+b7G4SzOGPXZXWprD5w90VbFL2x/dXwovwdypnBrqNsO728U
         3Rz3iUM5GVpk49epZwqwqFyRrHAug+pyAts2xrlSGbnzZfv/LyoCjfH6AdS2NAmCBVyv
         gSgR0dEEQnBPIozRp9Q8lwDjz1Ppb6FNpmBUtIKH6f9g2FyD+Fqjdo2bGSM17OvCdqx/
         Ci7VXEesBC3dML2FOuSa8BnJCiurQpezet6+XI85vJd7S0/U/SjWrUgk6reEec8Hwz+1
         +blg==
X-Gm-Message-State: AOJu0YwCB6pwhbbhvkAmZD1mtP8JYeyl0qjRmXgD6Y2NtY8f6jtfWP0w
	YBp8paXWHxU8zb/wy4m7YW7EbUMSKGg=
X-Google-Smtp-Source: AGHT+IHwiH2yIBCj6IVLmcajU2NRBrNBME27Mu1fSkIQ3Aaq4ybFPtVXMRcqgFPD7s4W02NYEoOpQU7IvwE=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:903:1251:b0:1cc:f1fe:9f60 with SMTP id
 u17-20020a170903125100b001ccf1fe9f60mr5888189plh.8.1701717770926; Mon, 04 Dec
 2023 11:22:50 -0800 (PST)
Date: Mon, 4 Dec 2023 11:22:49 -0800
In-Reply-To: <20231204173028.GJ1493156@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20231202091211.13376-1-yan.y.zhao@intel.com> <ZW4Fx2U80L1PJKlh@google.com>
 <20231204173028.GJ1493156@nvidia.com>
Message-ID: <ZW4nCUS9VDk0DycG@google.com>
Subject: Re: [RFC PATCH 00/42] Sharing KVM TDP to IOMMU
From: Sean Christopherson <seanjc@google.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Yan Zhao <yan.y.zhao@intel.com>, iommu@lists.linux.dev, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, alex.williamson@redhat.com, pbonzini@redhat.com, 
	joro@8bytes.org, will@kernel.org, robin.murphy@arm.com, kevin.tian@intel.com, 
	baolu.lu@linux.intel.com, dwmw2@infradead.org, yi.l.liu@intel.com
Content-Type: text/plain; charset="us-ascii"

On Mon, Dec 04, 2023, Jason Gunthorpe wrote:
> On Mon, Dec 04, 2023 at 09:00:55AM -0800, Sean Christopherson wrote:
> 
> > There are more approaches beyond having IOMMUFD and KVM be
> > completely separate entities.  E.g. extract the bulk of KVM's "TDP
> > MMU" implementation to common code so that IOMMUFD doesn't need to
> > reinvent the wheel.
> 
> We've pretty much done this already, it is called "hmm" and it is what
> the IO world uses. Merging/splitting huge page is just something that
> needs some coding in the page table code, that people want for other
> reasons anyhow.

Not really.  HMM is a wildly different implementation than KVM's TDP MMU.  At a
glance, HMM is basically a variation on the primary MMU, e.g. deals with VMAs,
runs under mmap_lock (or per-VMA locks?), and faults memory into the primary MMU
while walking the "secondary" HMM page tables.

KVM's TDP MMU (and all of KVM's flavors of MMUs) is much more of a pure secondary
MMU.  The core of a KVM MMU maps GFNs to PFNs, the intermediate steps that involve
the primary MMU are largely orthogonal.  E.g. getting a PFN from guest_memfd
instead of the primary MMU essentially boils down to invoking kvm_gmem_get_pfn()
instead of __gfn_to_pfn_memslot(), the MMU proper doesn't care how the PFN was
resolved.  I.e. 99% of KVM's MMU logic has no interaction with the primary MMU.

> > - Subjects IOMMUFD to all of KVM's historical baggage, e.g. the memslot deletion
> >   mess, the truly nasty MTRR emulation (which I still hope to delete), the NX
> >   hugepage mitigation, etc.
> 
> Does it? I think that just remains isolated in kvm. The output from
> KVM is only a radix table top pointer, it is up to KVM how to manage
> it still.

Oh, I didn't mean from a code perspective, I meant from a behaviorial perspective.
E.g. there's no reason to disallow huge mappings in the IOMMU because the CPU is
vulnerable to the iTLB multi-hit mitigation.

> > I'm not convinced that memory consumption is all that interesting.  If a VM is
> > mapping the majority of memory into a device, then odds are good that the guest
> > is backed with at least 2MiB page, if not 1GiB pages, at which point the memory
> > overhead for pages tables is quite small, especially relative to the total amount
> > of memory overheads for such systems.
> 
> AFAIK the main argument is performance. It is similar to why we want
> to do IOMMU SVA with MM page table sharing.
> 
> If IOMMU mirrors/shadows/copies a page table using something like HMM
> techniques then the invalidations will mark ranges of IOVA as
> non-present and faults will occur to trigger hmm_range_fault to do the
> shadowing.
>
> This means that pretty much all IO will always encounter a non-present
> fault, certainly at the start and maybe worse while ongoing.
> 
> On the other hand, if we share the exact page table then natural CPU
> touches will usually make the page present before an IO happens in
> almost all cases and we don't have to take the horribly expensive IO
> page fault at all.

I'm not advocating mirroring/copying/shadowing page tables between KVM and the
IOMMU.  I'm suggesting managing IOMMU page tables mostly independently, but reusing
KVM code to do so.

I wouldn't even be opposed to KVM outright managing the IOMMU's page tables.  E.g.
add an "iommu" flag to "union kvm_mmu_page_role" and then the implementation looks
rather similar to this series.

What terrifies is me sharing page tables between the CPU and the IOMMU verbatim. 

Yes, sharing page tables will Just Work for faulting in memory, but the downside
is that _when_, not if, KVM modifies PTEs for whatever reason, those modifications
will also impact the IO path.  My understanding is that IO page faults are at least
an order of magnitude more expensive than CPU page faults.  That means that what's
optimal for CPU page tables may not be optimal, or even _viable_, for IOMMU page
tables.

E.g. based on our conversation at LPC, write-protecting guest memory to do dirty
logging is not a viable option for the IOMMU because the latency of the resulting
IOPF is too high.  Forcing KVM to use D-bit dirty logging for CPUs just because
the VM has passthrough (mediated?) devices would be likely a non-starter.

One of my biggest concerns with sharing page tables between KVM and IOMMUs is that
we will end up having to revert/reject changes that benefit KVM's usage due to
regressing the IOMMU usage.

If instead KVM treats IOMMU page tables as their own thing, then we can have
divergent behavior as needed, e.g. different dirty logging algorithms, different
software-available bits, etc.  It would also allow us to define new ABI instead
of trying to reconcile the many incompatibilies and warts in KVM's existing ABI.
E.g. off the top of my head:

 - The virtual APIC page shouldn't be visible to devices, as it's not "real" guest
   memory.

 - Access tracking, i.e. page aging, by making PTEs !PRESENT because the CPU
   doesn't support A/D bits or because the admin turned them off via KVM's
   enable_ept_ad_bits module param.

 - Write-protecting GFNs for shadow paging when L1 is running nested VMs.  KVM's
   ABI can be that device writes to L1's page tables are exempt.

 - KVM can exempt IOMMU page tables from KVM's awful "drop all page tables if
   any memslot is deleted" ABI.

> We were not able to make bi-dir notifiers with with the CPU mm, I'm
> not sure that is "relatively easy" :(

I'm not suggesting full blown mirroring, all I'm suggesting is a fire-and-forget
notifier for KVM to tell IOMMUFD "I've faulted in GFN A, you might want to do the
same".

It wouldn't even necessarily need to be a notifier per se, e.g. if we taught KVM
to manage IOMMU page tables, then KVM could simply install mappings for multiple
sets of page tables as appropriate.
