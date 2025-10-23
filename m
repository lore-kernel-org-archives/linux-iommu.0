Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF8862BDC15;
	Thu, 23 Oct 2025 07:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761203290; cv=none; b=RDOBSM49LG/4mcnNvYKA2Rzqhfez3dG4PIIKsEgVHpZL0HevGzaykquIjS5WHyGXw7uYZvJvxHzAXF0M49eT458+MgXbu3ZmEh0MOU0vqijaCK8yz/1aGZso+IiJEKXKdwNpfQxVbfykMoMO6TNUmOknm682Q+PNiIalCTaR7PE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761203290; c=relaxed/simple;
	bh=/EbgptFjltHpGE9hJH8u5LNNSpy34GESNrMM1A23qrE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MjbefJdGVTZt2Gs/Ym3B8i6w2lW593k+I6q8A28yAvmIvLJH6vyO3UTIHIKpTOAhFFuijyGT87OOBFy+XgyS5Y8Noee26u7Ns1V3DfW0Apic8KLrcMfkPNU+wpQ7PxHnVfT2HfjL+eR3EkuzZEH6DmojRnoaMcy5/D9YZ3zUcwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rs6Ym6T7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rs6Ym6T7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5E66C4CEE7;
	Thu, 23 Oct 2025 07:08:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761203290;
	bh=/EbgptFjltHpGE9hJH8u5LNNSpy34GESNrMM1A23qrE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Rs6Ym6T7BbcLd2KezItSx+fYibGUohW2Oc/YROMvNUgniEYdltGFzwokK/M4/FMV/
	 FBB1t3/NKq91hyVRGvn7THYbYlRWMw1fT1ww2KiqLAPobMlwXaLN1xK6xNT5sccFlp
	 6Dmm+2s9jDQ6rAfygOUGJh2JtgSg6iEq0duU/jfdNb5+oKnkftxztWtbzoTDoQ0l92
	 ZsByAGWMX0IcXKLN2h+2i4Xhj+bXBVd/GwhHruCuVhF3KF4TfBlYYtP0HFZzZoL4so
	 ++JATIn7/Ez/asIWL0x1QTXGBThusMEMem1VF5Fud9HZCgQLB39GcfgWwqhJMJoC4B
	 MAQEfT4m+nAyw==
Date: Thu, 23 Oct 2025 10:07:57 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>, Jason Gunthorpe <jgg@nvidia.com>,
	Jann Horn <jannh@google.com>, Vasant Hegde <vasant.hegde@amd.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@intel.com>,
	Alistair Popple <apopple@nvidia.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Andy Lutomirski <luto@kernel.org>, Yi Lai <yi1.lai@intel.com>,
	David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@suse.cz>, Michal Hocko <mhocko@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	iommu@lists.linux.dev, security@kernel.org, x86@kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH v7 2/8] mm: Add a ptdesc flag to mark kernel page tables
Message-ID: <aPnUTfMXD7qReWUl@kernel.org>
References: <20251022082635.2462433-1-baolu.lu@linux.intel.com>
 <20251022082635.2462433-3-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251022082635.2462433-3-baolu.lu@linux.intel.com>

On Wed, Oct 22, 2025 at 04:26:28PM +0800, Lu Baolu wrote:
> From: Dave Hansen <dave.hansen@linux.intel.com>
> 
> The page tables used to map the kernel and userspace often have very
> different handling rules. There are frequently *_kernel() variants of
> functions just for kernel page tables. That's not great and has lead
> to code duplication.
> 
> Instead of having completely separate call paths, allow a 'ptdesc' to
> be marked as being for kernel mappings. Introduce helpers to set and
> clear this status.
> 
> Note: this uses the PG_referenced bit. Page flags are a great fit for
> this since it is truly a single bit of information.  Use PG_referenced
> itself because it's a fairly benign flag (as opposed to things like
> PG_lock). It's also (according to Willy) unlikely to go away any time
> soon.
> 
> PG_referenced is not in PAGE_FLAGS_CHECK_AT_FREE. It does not need to
> be cleared before freeing the page, and pages coming out of the
> allocator should have it cleared. Regardless, introduce an API to
> clear it anyway. Having symmetry in the API makes it easier to change
> the underlying implementation later, like if there was a need to move
> to a PAGE_FLAGS_CHECK_AT_FREE bit.
> 
> Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> Acked-by: David Hildenbrand <david@redhat.com>

Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

> ---
>  include/linux/mm.h | 41 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 41 insertions(+)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index d16b33bacc32..354d7925bf77 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -2940,6 +2940,7 @@ static inline pmd_t *pmd_alloc(struct mm_struct *mm, pud_t *pud, unsigned long a
>  #endif /* CONFIG_MMU */
>  
>  enum pt_flags {
> +	PT_kernel = PG_referenced,
>  	PT_reserved = PG_reserved,
>  	/* High bits are used for zone/node/section */
>  };
> @@ -2965,6 +2966,46 @@ static inline bool pagetable_is_reserved(struct ptdesc *pt)
>  	return test_bit(PT_reserved, &pt->pt_flags.f);
>  }
>  
> +/**
> + * ptdesc_set_kernel - Mark a ptdesc used to map the kernel
> + * @ptdesc: The ptdesc to be marked
> + *
> + * Kernel page tables often need special handling. Set a flag so that
> + * the handling code knows this ptdesc will not be used for userspace.
> + */
> +static inline void ptdesc_set_kernel(struct ptdesc *ptdesc)
> +{
> +	set_bit(PT_kernel, &ptdesc->pt_flags.f);
> +}
> +
> +/**
> + * ptdesc_clear_kernel - Mark a ptdesc as no longer used to map the kernel
> + * @ptdesc: The ptdesc to be unmarked
> + *
> + * Use when the ptdesc is no longer used to map the kernel and no longer
> + * needs special handling.
> + */
> +static inline void ptdesc_clear_kernel(struct ptdesc *ptdesc)
> +{
> +	/*
> +	 * Note: the 'PG_referenced' bit does not strictly need to be
> +	 * cleared before freeing the page. But this is nice for
> +	 * symmetry.
> +	 */
> +	clear_bit(PT_kernel, &ptdesc->pt_flags.f);
> +}
> +
> +/**
> + * ptdesc_test_kernel - Check if a ptdesc is used to map the kernel
> + * @ptdesc: The ptdesc being tested
> + *
> + * Call to tell if the ptdesc used to map the kernel.
> + */
> +static inline bool ptdesc_test_kernel(const struct ptdesc *ptdesc)
> +{
> +	return test_bit(PT_kernel, &ptdesc->pt_flags.f);
> +}
> +
>  /**
>   * pagetable_alloc - Allocate pagetables
>   * @gfp:    GFP flags
> -- 
> 2.43.0
> 

-- 
Sincerely yours,
Mike.
