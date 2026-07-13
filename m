Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D93C73CF678
	for <iommu@lists.linux.dev>; Mon, 13 Jul 2026 15:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783956457; cv=none; b=ZyxFdVXhb+pFyjpf76NqRW+lq63OqLY3uWIRdtTIg8w/mMlrT+hSwUeDqCZbqZPCk5QhIMV8KrS76LFdrCSVkkgcNzJGEHqLIWNTCS4+ZrdpP17b7+jZiG2qPuXOdKqf0ykd4Sck7QHURzIYexSZqaebR7D1Qk4DHFMwvCsX6j8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783956457; c=relaxed/simple;
	bh=UDZ7PKu4/O0+zD8UcRT03GCEPRQYFFg8hX0QNi0RHCM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZEt7vN6s5uYoXWWaAI9zjT340vcKVnXGv93/OrWy/e4fGUKPoYP5OpG20AfBHFrDqBfY4y5RzQM1L86KbuqUZ3C6j1Q8ehsb5QXNx3QkBjK8eY4Rs4Mnfm5dhKvObirtRj1jkNIBOxnJkI+5Ukx7s5tMY29VNY7FL+y0wXPcWwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uJ5h03AJ; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uJ5h03AJ"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-472326ca506so2689974f8f.2
        for <iommu@lists.linux.dev>; Mon, 13 Jul 2026 08:27:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783956454; x=1784561254; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Jfq663FOi5VReF455I+cgLjdnh8pMmbvEI+PrxOvHAY=;
        b=uJ5h03AJDoGs7iT5hkZsTdcQ742JCEpkUA8i+FDvUyIU025qo+9QajTKaMk/t8b3k6
         FhaCb/92PU8CDV+YRYLmA5HV3WatR8108UO2uovK3351+U3SRZGw+VWymMN2LdvuQ8dO
         JZqioILb2rPfPRAJjcJZeC9/OdR88vBcTDtRSjVC5IxJkuK3v+QPW9b246/6MghyPbSs
         XXvPVadNp2CicuO6eqJRQUsmSw7WIVl4P2F94AyoVe2Lli/+fFdHYr5DRkKNYGfVAifR
         RHsPbJb6cp2LZzMcyfSLO5pagLvxgoyWr3oit8/wEmdIk/kHyZpUy7kbqGJKS6iA0X8h
         DiDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783956454; x=1784561254;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Jfq663FOi5VReF455I+cgLjdnh8pMmbvEI+PrxOvHAY=;
        b=XZOt53OXniL1wb0GVQdJBy6TqxO45aFKIq7fqu+xJPe1ei8Hwac0LXrNprjIapdJlZ
         1q1wdLJ1ZukmYf8R8umitMK6PxcKYKrcH7eDRqxaYTIHBa2SYD2DjxmIPuppS9p7EzwP
         5QiZO4EYMjIFWtIvSznvqiKm1YQgeDD5qHCqPpYKXojt8q9HEi1eMo2lKbv2l/N7ChHS
         XVnO8PfSQleok/Vrz0zvREdaQEe4Y2iTmVluvXDnrup+lZXqNpM7KQkq7aDuYxc0BXb1
         HFZ7wOoDQ8MSDAlcOIfm0k7ksfjCCb8a/JFq+AX1eR3exPeVngzhPt6JPKXNt1ELvy7c
         9piw==
X-Forwarded-Encrypted: i=1; AHgh+RqfaHzVfYb4+LIYDZLyfacRt2Pap0ccvuNDcSObpWpvuvRRTeOKXPQGiWEaSLB7J+DsqiN3gg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzbD2T6tPbzwKKMsO1zSxcNhrYaQSXe3LfqkCV0sew2P7qSLzTs
	1qCmeyXbdn3rXcsbcUE3Nez+Pgc14jB+TNpCs3/KEPL8yjWB59miYkbcfgiJ5kWWnQ==
X-Gm-Gg: AfdE7cnZysB9IF25kgZP4vCcwNn3IF++P9u8vXcqNC+6ghGJasnb8w9gOKGgWtWfFQg
	uMlSfV5tJrOi0QNL2f6onyZzliXa9wuKRzz82s+/ERYHMB0RfIsLVuwZGX4l1XYrtHTJjQUM4z8
	+xxV6Er+ERFSU81NklQIun3e2Pp+9ehDMLq9JM6TCicIZtADUy60w75GUMR3OpLzsE8Ntc2xFIa
	U/8t+g5FMnNv9AHaaKG6/k9ih23YXhrvhKmBUy+A0fyyoVgSeWmygc57rFsKRS+rOGCk0c3C1sm
	SctzrIL0kSdAeN5i8duMA4rPLc7BP33qkE5s4tVOy9vTsUb5wogWPcTNR15sdFeMxaV6/t0KPUd
	CaDX8AreyYCVm1mE6OgxtCNTYf9gIPia+yW9tDQqWvsTEzLkqpsG6eT/ZPhz7SJQwH9JKcfKrU1
	6l5OHyyOKiLujrDicENW0ymAkrfdI8oCVT6QLTx51J/lRkTTU+eR0=
X-Received: by 2002:a7b:cd93:0:b0:494:596e:e8c4 with SMTP id 5b1f17b1804b1-494596ee8d1mr16030915e9.17.1783956453604;
        Mon, 13 Jul 2026 08:27:33 -0700 (PDT)
Received: from google.com (137.69.77.34.bc.googleusercontent.com. [34.77.69.137])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f464c9cc3sm57292f8f.35.2026.07.13.08.27.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 08:27:28 -0700 (PDT)
Date: Mon, 13 Jul 2026 16:27:16 +0100
From: Vincent Donnefort <vdonnefort@google.com>
To: Mostafa Saleh <smostafa@google.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kvmarm@lists.linux.dev, iommu@lists.linux.dev,
	catalin.marinas@arm.com, will@kernel.org, maz@kernel.org,
	oliver.upton@linux.dev, joey.gouly@arm.com, suzuki.poulose@arm.com,
	yuzenghui@huawei.com, joro@8bytes.org, jean-philippe@linaro.org,
	jgg@ziepe.ca, mark.rutland@arm.com, qperret@google.com,
	tabba@google.com, sebastianene@google.com, keirf@google.com
Subject: Re: [PATCH v6 08/25] KVM: arm64: iommu: Shadow host stage-2 page
 table
Message-ID: <alUD1IiSgNkhzFGR@google.com>
References: <20260501111928.259252-1-smostafa@google.com>
 <20260501111928.259252-9-smostafa@google.com>
 <alTnAy7jvjUamwUA@google.com>
 <alTvf7iiOWn4PKE8@google.com>
 <alUA7zsJO1FGnss-@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alUA7zsJO1FGnss-@google.com>

On Mon, Jul 13, 2026 at 04:14:55PM +0100, Vincent Donnefort wrote:
> On Mon, Jul 13, 2026 at 02:00:31PM +0000, Mostafa Saleh wrote:
> > On Mon, Jul 13, 2026 at 02:24:19PM +0100, Vincent Donnefort wrote:
> > > On Fri, May 01, 2026 at 11:19:10AM +0000, Mostafa Saleh wrote:
> > > > Create a page-table for the IOMMU that shadows the host CPU stage-2
> > > > to establish DMA isolation.
> > > > 
> > > > An initial snapshot is created after the driver init, then
> > > > on every permission change a callback would be called for
> > > > the IOMMU driver to update the page table.
> > > > 
> > 
> > [...]
> > 
> > > > +	 */
> > > > +	if (pte && !kvm_pte_valid(pte))
> > > > +		return 0;
> > > > +
> > > > +	if (kvm_pte_valid(pte)) {
> > > > +		prot = pkvm_to_iommu_prot(kvm_pgtable_stage2_pte_prot(pte));
> > > > +		/* If the range is mapped in a single PTE, it must be the same type.*/
> > > > +		if (!addr_is_memory(start))
> > > > +			prot |= IOMMU_MMIO;
> > > > +
> > > > +		return kvm_iommu_ops->host_stage2_idmap(start, end, prot);
> > > 
> > > Do we really need to do that when is_memory()? 
> > > 
> > > fix_host_ownership_walker() by calling host_stage2_idmap_locked() and
> > > host_stage2_set_owner_locked() should already handle the memory region. That
> > > would also get rid of kvm_idmap_initialized.
> > > 
> > > So this one here could only take care of the MMIO?
> > > 
> > > Overall we would have a common point of synchro which is
> > > fix_host_ownership_walker() after which the host ownership is ready for both
> > > CPU stage-2 and the IOMMU?
> > > 
> > 
> > I am not sure I understand, this is another empty page table, so we
> > have to walk all of the host CPU stage-2 page table to shadow it in the
> > IOMMU. if you are refering to the case where it handle zero ptes for
> > memory, I can drop that but it will not change much in this logic.
> 
> In fixup_host_ownership() we already walk the hyp pgtable to know what needs to be
> map/unmapped from the host stage-2. Can't we rely on that for the IOMMU
> page-table as well?
> 
> As of, fix_host_ownership() could handle the host stage-2 __and__ the iommu? 

What I have in mind is the completely untested snippet:

index 75b00c323310..64cd175ad6c0 100644
--- a/arch/arm64/kvm/hyp/nvhe/setup.c
+++ b/arch/arm64/kvm/hyp/nvhe/setup.c
@@ -226,10 +226,11 @@ static int fix_host_ownership_walker(const struct kvm_pgtable_visit_ctx *ctx,
        case PKVM_PAGE_SHARED_OWNED:
                set_hyp_state(page, PKVM_PAGE_SHARED_OWNED);
                set_host_state(page, PKVM_PAGE_SHARED_BORROWED);
+               kvm_iommu_host_stage2_idmap(phys, PAGE_SIZE, IOMMU_READ | IOMMU_WRITE);
                break;
        case PKVM_PAGE_SHARED_BORROWED:
                set_hyp_state(page, PKVM_PAGE_SHARED_BORROWED);
-               set_host_state(page, PKVM_PAGE_SHARED_OWNED);
+               kvm_iommu_host_stage2_idmap(phys, PAGE_SIZE, IOMMU_READ | IOMMU_WRITE);
                break;
        default:
                return -EINVAL;
@@ -258,15 +259,20 @@ static int fix_host_ownership(void)
                .cb     = fix_host_ownership_walker,
                .flags  = KVM_PGTABLE_WALK_LEAF,
        };
+       u64 mmio = 0;
        int i, ret;

        for (i = 0; i < hyp_memblock_nr; i++) {
                struct memblock_region *reg = &hyp_memory[i];
                u64 start = (u64)hyp_phys_to_virt(reg->base);

+               kvm_iommu_host_stage2_idmap(mmio, start, IOMMU_READ | IOMMU_WRITE | IOMMU_MMIO);
+
                ret = kvm_pgtable_walk(&pkvm_pgtable, start, reg->size, &walker);
                if (ret)
                        return ret;
+
+               mmio = start + reg->size;
        }

I believe this does the same as kvm_iommu_snapshot_host_stage2(). WDYS?

> 
> > 
> > > > +	}
> > > > +
> > > > +	/* In case of invalid PTE, we need to figure out which part of it is MMIO */
> > 
> > [...]
> > 
> > > >  #include <nvhe/mm.h>
> > > > @@ -481,6 +482,14 @@ static int check_range_allowed_memory(u64 start, u64 end)
> > > >  	return 0;
> > > >  }
> > > >  
> > > > +u64 find_mem_range_from(u64 start, bool *is_memory)
> > > > +{
> > > > +	struct kvm_mem_range r;
> > > > +
> > > > +	*is_memory = !!find_mem_range(start, &r);
> > > > +	return r.end;
> > > > +}
> > > > +
> > > >  static bool range_is_memory(u64 start, u64 end)
> > > >  {
> > > >  	struct kvm_mem_range r;
> > > > @@ -577,8 +586,34 @@ int host_stage2_idmap_locked(phys_addr_t addr, u64 size,
> > > >  
> > > >  static void __host_update_page_state(phys_addr_t addr, u64 size, enum pkvm_page_state state)
> > > 
> > > I would really split this. I know that this is convinient, but as the function
> > > says, it only update the page state so it shouldn't hide an update to the IOMMU.
> > 
> > I mention a couple of alternatives in the commit message, I tried to
> > implement it differently which was harder to reason about as the calls
> > was scattered everywhere and any small refactor will possibly break it.
> > 
> > Did you have a split in my mind? I open to rework it.
> 
> Yes, I meant the option #2.
> 
> > 
> > > 
> > > Beside, we have examples already in Android where we want to update the
> > > page-state but not the IOMMU, so it doesn't feel future-proof...
> > > 
> > > >  {
> > > > +	enum pkvm_page_state old = get_host_state(hyp_phys_to_page(addr));
> > > > +	enum kvm_pgtable_prot prot = 0;
> > > > +
> > > >  	for_each_hyp_page(page, addr, size)
> > > >  		set_host_state(page, state);
> > > > +
> > > > +	/*
> > > > +	 * Any transition to PKVM_NOPAGE, unmaps the page from the host
> > > > +	 * Any transition to PKVM_PAGE_SHARED_BORROWED, maps the page in the host
> > > > +	 * Any transition to PKVM_PAGE_SHARED_OWNED is ignored as page is already mapped.
> > > > +	 * Transitions to PKVM_PAGE_OWNED from anything but PKVM_NOPAGE are ignored.
> > > > +	 * Transitions to PKVM_PAGE_OWNED from PKVM_NOPAGE will map the page.
> > > > +	 */
> > > > +	if ((state == PKVM_PAGE_SHARED_OWNED) ||
> > > > +		((state == PKVM_PAGE_OWNED) && (old != PKVM_NOPAGE)))
> > > > +		return;
> > > > +
> > > > +	if ((state == PKVM_PAGE_SHARED_BORROWED) ||
> > > > +		(state == PKVM_PAGE_OWNED))
> > > > +		prot = PKVM_HOST_MEM_PROT;
> > > 
> > > ... and that would avoid that sort of things here. The caller decides if the IOMMU
> > > is updated or not.
> > 
> > Typically, the IOMMU is updated if the CPU is.
> > 
> > > 
> > > And as the patch says, we "shadow" the host stage2. So probably modifying
> > > host_stage2_idmap and host_stage2_set_owner_metdata() sounds really a better
> > > approach.
> > 
> > Initially, before the pKVM merge upstream I was doing something similar
> > as that only required one hook [1]. However, after rebasing I found that
> > would be too complicated and I have to add many more (as mentioned in
> > the commit message). But I can re-visit this approach in v7.
> 
> What bit would be more complicated? As you've wrote in the commit message, in
> option#2 you only need two calls really:
> 
>   * host_stage2_set_owner_locked()
>   * host_stage2_set_owner_metadata_locked().
> 
> This fits better the narative for the "shadow" page-table: when we map the host
> stage-2, we map the iommu and when we unmap the host stage-2, we unmap the
> iommu.
> 
> > 
> > [1] https://lore.kernel.org/all/20250819215156.2494305-11-smostafa@google.com/
> > 
> > Thanks,
> > Mostafa
> > 
