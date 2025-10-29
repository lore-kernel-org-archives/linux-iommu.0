Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B89FA3358AF
	for <iommu@lists.linux.dev>; Wed, 29 Oct 2025 13:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761744878; cv=none; b=eAoDK078IhQva28TwwlJdTGMoLDO+r+lq9VNdYuo5laj+7n+W+0CiX5/Zq+eCshqWN6YqEfCN1yENtp5nPdF8phn7usSeP6tVYOQKedMhhvtXWveBbaJCd/sVHzgpedeTDNdSzZdQpLQADi8L2ui57TGYtryab4Uh5jnIiNWxh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761744878; c=relaxed/simple;
	bh=oM5QySZdtAOBCoyNMz4xxycx+fUx6QiRo34fuhCV6ss=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a5T34g4+CuD+Hg5BfEM8t5UVI9KlLg8sWwkjwBsEdmLm81DQmsbpntgmLso/WTHP3Udp6RRMHC3s69QqVRipKLJGfANydpNJoGoMTH39Bx/nEiWI7rTjCuv7UL5513WxfDVaUOgtN93TNr80xH5tTFU1jr+Erw5HHFthLMiYx8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Yn5NNOPT; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Yn5NNOPT"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4eceef055fbso75619311cf.0
        for <iommu@lists.linux.dev>; Wed, 29 Oct 2025 06:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1761744875; x=1762349675; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RgADETiD5u9wqQNfgMacoJuuGaSmA2poVcbRTgfiI8k=;
        b=Yn5NNOPTtC82PgUXlkltZUr/OFcu+iOpemmY3GtL6FfxPk6OT4Kp9jghrKS9F7rERM
         3Fg1cdNcqGN9gzadHtcgYCA/56alsLEJO4W4YBNZ8x++0OKqqfkguhvRZOcV7zLp1lNz
         dxJbn++15ENbSNbqGaW3xujuXWjkgWDO59I4so5UIDf1EDJLhNQaUsmVcJ1HPXTZKMfq
         q8AW1Z7nh4XjgErygQMfkvAkoGoECOuR+iGg3hb3s7wyx1WVJa3vPdAYci/cTAGySxXj
         YehVxar84BE1v2+TOai1+B6gz0BaFNTZ/43VHPUYhyhB5h2yS3a7lXJDQbeDa6goUH50
         lT5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761744875; x=1762349675;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RgADETiD5u9wqQNfgMacoJuuGaSmA2poVcbRTgfiI8k=;
        b=XuiBVyXOYrNjOlmqcWDajJoWXNtFIo7xtYrIqzk+brajpZfheYRWRq8roendMbGhzV
         uPGYlKb84T9LyPMsG7xuEMigqF9D0WN/sH9xMyiFwuSC9uy0gf47G/BADNUPmErQ55Ql
         B4RnBOQhlPAbPqvkfJcJFZ5d8jKxQRA7VrFZCaEoUlzPzI0QHi3GXofjYSZbzVyUYQKB
         7InLxtqs0yJE5Ub2YZ15VEz9s2p/rfKvcPR2OP9ktTZ8GXQMc1vn+bTFvXv7xjhKWscd
         p6GzRV1ruP4XOFeDsvrORR+WbZDalWESPeEZ8JshYlN8qUNDi1lh3a9/4CvgoitmO9Pt
         VG9A==
X-Gm-Message-State: AOJu0YxddjJtdbJbWZQ66qLz2Pd+UoZFaKwJY20StqSoKnyYBGy7/kXN
	DbDIf3mm9BKSY+nujAsOjefkYjhmWvWxPqoZ5TTnh8CaE5DCmdC11h/I7TAqhoSgXBA=
X-Gm-Gg: ASbGncucZ+UUdLqbsEqjJ+81EplNa/klAzf9yMH2BANbUFAN4AXcbMJeLD4Hh49spml
	wTBEWcB4cq8iFXnWnKsqPSBgJlVB+gsNef571PgQUy/waKXGslrYOIrGbD0AJFjaS7uhWuFXy/R
	iD1QopjJIw3Raqspv/Y1bYu/IbwJWUXgoot6kvN893mG7hVLftlF+L8sAwtLdCkN1rvJ6fQrknQ
	MsCfn4c2SGRJWksIdF+Bs3ZpQEnkwDHk5Kd/af+LCQ183KStE14GwYc96/Dw1NPgtd2eud2QTLO
	+wn7FVPEZe44AMD6AWlZVe2afHkliFzC6fXFE1FC3gHWznuil4lqIUtVYIMtvc92SQI1zJZiDv/
	ScoJiHy19Yx4pGrU9MKXJdwSWDyRLuuQiqMk4LkqnTIDhjNFuj6Y1n+XZXWicFN7zqH0TpRCa5z
	c5Pxttmk8Jo83xT3xCSHRklsHko2oZfYM6jDG78A+WS//a9lyPSsmXIflP
X-Google-Smtp-Source: AGHT+IFdgVvZSdHjEy8GA0OS5tZk1Dvc3yZ1jqJfpcS1F8qZqGGicMQtvw7HnfgbOqouiYpmJyOhTA==
X-Received: by 2002:a05:622a:91:b0:4ed:698:e3af with SMTP id d75a77b69052e-4ed15b336c0mr38693411cf.13.1761744875380;
        Wed, 29 Oct 2025 06:34:35 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4eba37d68e9sm93871021cf.8.2025.10.29.06.34.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 06:34:34 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vE6Ju-00000004eMm-0ufq;
	Wed, 29 Oct 2025 10:34:34 -0300
Date: Wed, 29 Oct 2025 10:34:34 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Shuai Xue <xueshuai@linux.alibaba.com>
Cc: iommu@lists.linux.dev, kevin.tian@intel.com, joro@8bytes.org,
	will@kernel.org, robin.murphy@arm.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu: iommufd: Explicitly check for VM_PFNMAP in
 iommufd_ioas_map
Message-ID: <20251029133434.GL760669@ziepe.ca>
References: <20251029125226.81949-1-xueshuai@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251029125226.81949-1-xueshuai@linux.alibaba.com>

On Wed, Oct 29, 2025 at 08:52:26PM +0800, Shuai Xue wrote:
> The iommufd_ioas_map function currently returns -EFAULT when attempting
> to map VM_PFNMAP VMAs because pin_user_pages_fast() cannot handle such
> mappings. This error code is misleading and does not accurately reflect
> the nature of the failure.

Sure, but why do you care? Userspace should know not to do this based
on how it created the mmaps, not rely on errnos to figure it out after
the fact.

> +static bool iommufd_check_vm_pfnmap(unsigned long vaddr)
> +{
> +	struct mm_struct *mm = current->mm;
> +	struct vm_area_struct *vma;
> +	bool ret = false;
> +
> +	mmap_read_lock(mm);
> +	vaddr = untagged_addr_remote(mm, vaddr);
> +	vma = vma_lookup(mm, vaddr);
> +	if (vma && vma->vm_flags & VM_PFNMAP)
> +		ret = true;
> +	mmap_read_unlock(mm);

This isn't really sufficient, the range can span multiple VMAs and you
can hit special PTEs in PFNMAPs, or you can hit P2P struct pages in
fully normal VMAs.

I think if you really want this errno distinction it should come from
pin_user_pages() directly as only it knows the reason it didn't work.

Jason
