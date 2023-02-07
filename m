Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0462428FD
	for <iommu@lists.linux.dev>; Tue,  7 Feb 2023 12:54:03 +0000 (UTC)
Received: by mail-wm1-f44.google.com with SMTP id m16-20020a05600c3b1000b003dc4050c94aso11370515wms.4
        for <iommu@lists.linux.dev>; Tue, 07 Feb 2023 04:54:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4QuannVmSHFP8CTOkjD+KCXiZMHzjfWOZhA9rSOUw4Y=;
        b=H7C/fJovnRJnlsdgMORYCoeKTFtNuLWBmwFh7QdY4vyHJuvsudMTreHQinBwNgAsqa
         VYYYx7w27CtvciflkFbVfKkajtCN0zqzX1baUn5QLSNcTiN3tzPbLcx4ifDiZlB1U9ws
         nB+Hs02PX1pVWwELBKdnqoCpUMiChTJ3uGGDBfGvyf52TzMizq3AxNOcToZBUzMdgB2Y
         3kaW1WQPe/VZm7+vS+py8mIM1cRac1Y4kKdTcXpoTwXWwkk1MgS6kcHXbQ1YDBN9PZpb
         myJa+kTd0dSTynOvOr8dg/BQZNZGzPKNPk7OBfzdCwxKgwbMzLl1dLjROf8kIoemTSE+
         a8rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4QuannVmSHFP8CTOkjD+KCXiZMHzjfWOZhA9rSOUw4Y=;
        b=ihHCYbueZqzaCYbEA0ydnR4TJXBvgVbvOwAAVV+X6tVBxBZmgzEMot1Po4fJnj4iIo
         ySawXkrAP38Q7QxXABXtp/SrbWyNN56eSfkn4N0TsNAzbBpmpRCRVwOPwZmRsdE0DAWC
         7KdnAkJHHFS9N0TrjyDggHHw1YdN5//6LzUFqIqYc4cH7mm7sp3UxUAE38XTjpEq5FWF
         FqPiip/bxlgYoYfCu/WkC4XctmIcIjY5vnT5uQ/spftpp1Sfn4YLXwXxlvRvGCWtqKYr
         cBBK28T3exJ068GVaXVUTDs2jvzf2XCHa5mcTmEiKKrxXRVJT8WQ96azyxbojmk8Pmqu
         jukw==
X-Gm-Message-State: AO0yUKXZD0tbw/1YqDiJOmspshy9l3XtFhBJJuVCMs+fr5FzOqXdwg3L
	f3Rc6zBIqF3VriZAB8O1dyklFQ==
X-Google-Smtp-Source: AK7set+oJx+kB+cL+65FcAkL6WDKujzT+Yv9c9twshHVe5WdW4BsLtqePLR+qGveuyEBE6Ayp8umgg==
X-Received: by 2002:a05:600c:468e:b0:3dc:434b:39b4 with SMTP id p14-20020a05600c468e00b003dc434b39b4mr167184wmo.2.1675774442255;
        Tue, 07 Feb 2023 04:54:02 -0800 (PST)
Received: from google.com (44.232.78.34.bc.googleusercontent.com. [34.78.232.44])
        by smtp.gmail.com with ESMTPSA id p16-20020a5d4e10000000b002c3e4bec4dbsm6269840wrt.89.2023.02.07.04.54.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Feb 2023 04:54:01 -0800 (PST)
Date: Tue, 7 Feb 2023 12:53:56 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc: maz@kernel.org, catalin.marinas@arm.com, will@kernel.org,
	joro@8bytes.org, robin.murphy@arm.com, james.morse@arm.com,
	suzuki.poulose@arm.com, oliver.upton@linux.dev,
	yuzenghui@huawei.com, dbrazdil@google.com, ryan.roberts@arm.com,
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
	iommu@lists.linux.dev
Subject: Re: [RFC PATCH 15/45] KVM: arm64: pkvm: Add
 __pkvm_host_share/unshare_dma()
Message-ID: <Y+JJ5HJpKGy3P04V@google.com>
References: <20230201125328.2186498-1-jean-philippe@linaro.org>
 <20230201125328.2186498-16-jean-philippe@linaro.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230201125328.2186498-16-jean-philippe@linaro.org>

Hi Jean,

On Wed, Feb 01, 2023 at 12:52:59PM +0000, Jean-Philippe Brucker wrote:
> Host pages mapped in the SMMU must not be donated to the guest or
> hypervisor, since the host could then use DMA to break confidentiality.
> Mark them shared in the host stage-2 page tables, and keep a refcount in
> the hyp vmemmap.
> 
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> ---
>  arch/arm64/kvm/hyp/include/nvhe/mem_protect.h |   3 +
>  arch/arm64/kvm/hyp/nvhe/mem_protect.c         | 185 ++++++++++++++++++
>  2 files changed, 188 insertions(+)
> 
> diff --git a/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h b/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
> index 021825aee854..a363d58a998b 100644
> --- a/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
> +++ b/arch/arm64/kvm/hyp/include/nvhe/mem_protect.h
> @@ -58,6 +58,7 @@ enum pkvm_component_id {
>  	PKVM_ID_HOST,
>  	PKVM_ID_HYP,
>  	PKVM_ID_GUEST,
> +	PKVM_ID_IOMMU,
>  };
>  
>  extern unsigned long hyp_nr_cpus;
> @@ -72,6 +73,8 @@ int __pkvm_host_share_guest(u64 pfn, u64 gfn, struct pkvm_hyp_vcpu *vcpu);
>  int __pkvm_host_donate_guest(u64 pfn, u64 gfn, struct pkvm_hyp_vcpu *vcpu);
>  int __pkvm_guest_share_host(struct pkvm_hyp_vcpu *hyp_vcpu, u64 ipa);
>  int __pkvm_guest_unshare_host(struct pkvm_hyp_vcpu *hyp_vcpu, u64 ipa);
> +int __pkvm_host_share_dma(u64 phys_addr, size_t size, bool is_ram);
> +int __pkvm_host_unshare_dma(u64 phys_addr, size_t size);
>  
>  bool addr_is_memory(phys_addr_t phys);
>  int host_stage2_idmap_locked(phys_addr_t addr, u64 size, enum kvm_pgtable_prot prot);
> diff --git a/arch/arm64/kvm/hyp/nvhe/mem_protect.c b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
> index 856673291d70..dcf08ce03790 100644
> --- a/arch/arm64/kvm/hyp/nvhe/mem_protect.c
> +++ b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
> @@ -1148,6 +1148,9 @@ static int check_share(struct pkvm_mem_share *share)
>  	case PKVM_ID_GUEST:
>  		ret = guest_ack_share(completer_addr, tx, share->completer_prot);
>  		break;
> +	case PKVM_ID_IOMMU:
> +		ret = 0;
> +		break;
>  	default:
>  		ret = -EINVAL;
>  	}
> @@ -1185,6 +1188,9 @@ static int __do_share(struct pkvm_mem_share *share)
>  	case PKVM_ID_GUEST:
>  		ret = guest_complete_share(completer_addr, tx, share->completer_prot);
>  		break;
> +	case PKVM_ID_IOMMU:
> +		ret = 0;
> +		break;
>  	default:
>  		ret = -EINVAL;
>  	}
> @@ -1239,6 +1245,9 @@ static int check_unshare(struct pkvm_mem_share *share)
>  	case PKVM_ID_HYP:
>  		ret = hyp_ack_unshare(completer_addr, tx);
>  		break;
> +	case PKVM_ID_IOMMU:
> +		ret = 0;
> +		break;
>  	default:
>  		ret = -EINVAL;
>  	}
> @@ -1273,6 +1282,9 @@ static int __do_unshare(struct pkvm_mem_share *share)
>  	case PKVM_ID_HYP:
>  		ret = hyp_complete_unshare(completer_addr, tx);
>  		break;
> +	case PKVM_ID_IOMMU:
> +		ret = 0;
> +		break;
>  	default:
>  		ret = -EINVAL;
>  	}
> @@ -1633,6 +1645,179 @@ void hyp_unpin_shared_mem(void *from, void *to)
>  	host_unlock_component();
>  }
>  
> +static int __host_check_page_dma_shared(phys_addr_t phys_addr)
> +{
> +	int ret;
> +	u64 hyp_addr;
> +
> +	/*
> +	 * The page is already refcounted. Make sure it's owned by the host, and
> +	 * not part of the hyp pool.
> +	 */
> +	ret = __host_check_page_state_range(phys_addr, PAGE_SIZE,
> +					    PKVM_PAGE_SHARED_OWNED);
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * Refcounted and owned by host, means it's either mapped in the
> +	 * SMMU, or it's some VM/VCPU state shared with the hypervisor.
> +	 * The host has no reason to use a page for both.
> +	 */
> +	hyp_addr = (u64)hyp_phys_to_virt(phys_addr);
> +	return __hyp_check_page_state_range(hyp_addr, PAGE_SIZE, PKVM_NOPAGE);

This works for hyp-host sharing, I am worried about scalability of this.
For example FFA(still on the list) adds a new entity that can share data
with host, and we would need an extra check for it.
https://lore.kernel.org/kvmarm/20221116170335.2341003-1-qperret@google.com/

One way I can think about this, is to use the SW bits in SMMU page table to
represent ownership, for example for PKVM_ID_IOMMU
do_share:
-completer: set SW bits in the SMMU page table to
PKVM_PAGE_SHARED_BORROWED

do_unshare:
-completer: set SW bit back to PKVM_PAGE_OWNED(I think this is good
enough for host ownership)

In __pkvm_host_share_dma_page
If page refcount > 1, it succeeds if only the page was borrowed in the
SMMU page table and shared in the host page table.


Thanks,
Mostafa

