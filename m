Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E51C2CCB9
	for <iommu@lists.linux.dev>; Thu,  9 Jul 2026 00:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783555574; cv=pass; b=o2C1xfu51nkp8DAqc5+IuOXiYiEVQpkG2incNDOIAb74FnDL1BKMFHCjjh7PBX5/aFu60/CaXEZVizaSXBhdRYdJveLWnknZBHoEm6ch/NT0Acuw6UuJ0/d3EkZsRSZFk/nn1gsZaicr64Th9jHxWKxvJVkm5gJfkH7ondIfQ9s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783555574; c=relaxed/simple;
	bh=4EuRdo8+QeN+yDW6A3X+o12IBSIMc42jYmwxuetdwEg=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fMd2yOmStY8nFDasfbUN811LLnxgF1KaoH7huAelGw+MxkHKRIOQoi6xHl2nYaInOJsonI4A4EM7k2TW1/1I6EIfro8A3QxuJB4SVQahNjBQP/GYOHMi74zPstN6R5nBQgM3CHWoAEHLR6meYaHUqwKIq+7OAluDoIvUR0WBeA0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XKtvWcaU; arc=pass smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XKtvWcaU"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-381507c9380so954378a91.0
        for <iommu@lists.linux.dev>; Wed, 08 Jul 2026 17:06:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783555572; cv=none;
        d=google.com; s=arc-20260327;
        b=hPXJ+OJQ9GfUiSCShIH0vGRwbSd0EX8gw23BkvE4Np/G5Dpta+bJDx5bKklr+HrDCj
         ecyIe5lo6iQcq2aO3GIB/7xSVh0M9OkWQTHNpVjrOfFieBsEL/N1tEL+LWG14QmJnnQf
         Uz0ZiiF+72GuV4bE6Kx5stXS89yizL7WZXgzj6aQWreTKr4xbna9HPph4bI1w51gidFM
         XBMOUZBOrmxGJ4Atcwzx4NGQsFe5IuvVrQD1OtF12avDmj7tu4c/sZ9GyyQG2Bs6n9tc
         oTz43T3Ul4hBAVyDB2VdbBeYfw2LH1QTbVabXmPIMnHfD6DfL2CQ2haOakl3tP6ZekLt
         tSHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=LGyVs/ziq+v8OBPSx6ZOv0f1yGdel9dIe8uNrAG5/8g=;
        fh=oGHS/5twEdEdJ42jxWA9K7zDGG7A3csx0qpsdOihPoE=;
        b=Aycr8DV34Vmq8sqdaifAekU+WzSvjBg+MGija9iVjzuheukQvaBnJTsimNJ4lrO74T
         f01FIKhT/UikKzxa7uYyXgmSilcKimZpsdNHWTvY//1C7y0Pi16/fn8zsG0/X4u4cNFv
         gpb8YsG7YbtlbBBOtR/I3r8JFIN2h318IAKFrthyIyMHO6Igr0Pe1hHWFWSsJ2CbSzY+
         Dzbzt8JVd/Df4GXgODtCQYqCIUwcXSetqHgmPNGV7wYru5DJSfYVCIIC2id3l/lX3jwW
         Zb9eJdvfgsBmE0QAg175zRhVlYvj03/EvScnmohUhfGV4yxyjcdM/WSIDPUunFZlxstV
         4Mtg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783555572; x=1784160372; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LGyVs/ziq+v8OBPSx6ZOv0f1yGdel9dIe8uNrAG5/8g=;
        b=XKtvWcaUeMg37vNhALFpyIhrbaZf5r2T1KGTcH7mIQ88xMehpr+Gv0Tu31bihIsb5x
         OMdZXajFAnXwtfczv8SHsVuP6JGoBo34OJljB03Zqn807vm5XGFW/H3M1bNtOsF4jlOt
         ZDMpvdPf3EE5xH4HRvdmUu+/jHSuJ7uxHfuboG2vNnR0csggcQ9d77WKp0EBx8AtuEab
         A6X1aIyPJ7KzhdXh880J6ld2TfyJ5r02PHuzlwThux4aajKFIA4mfJH1R2ZJk+jf8vHv
         +u2ol16KYg/zpSVPxjez1KKyQPicmonSuyfwCky1NVRsp/sFx/USbFABsb7lgtCIaE1O
         DuuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783555572; x=1784160372;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LGyVs/ziq+v8OBPSx6ZOv0f1yGdel9dIe8uNrAG5/8g=;
        b=U9Vws3FWSSlWXn6LzcHMahLWLwwcgw7UysXOQHitEJgucDG3Br/QsoV8jJEMhCO3XD
         JEFd9j10yWLtyxljXXU1kixucY2cDEsWXfp5AfcpstdEdd4Fns5etvBo4yR5+1iAJrpT
         PKJpgU75qS/eiCwZok/txgrIFRpt4YeZCTqpb0ggQcB0V1mdoKRNy1XPjI8E9K0S/p0j
         2vjgpmTOkaOK9QUFr4IXCkXMHJoi0e+5HB7Q2ACJD5wjyOwcYkZBwM5ZbSE5FOb2O6/w
         wIYHV56cKm58474whF8Y/f9tcXTabVgsszU79Qrh83yz+V8fNByXuQf77fOgk/AFqHKu
         Ga/g==
X-Forwarded-Encrypted: i=1; AHgh+Rr7rfES5Q7/WvFP8WYUKCnJedK7pU2TwBVAKs+owg4puRclxMHde+lP1XXNQaoYh5jDj6Q52w==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywewr4R9ilrTdYAkEl0HXheyZyKgvNzEUPchfMz3bDbqzz4w+r2
	OuZNUbhxSreuRPtuKyryAA5WHkRL6XAvQNOmAopW49exftBcbqiACXlruVwr32SYCZYx07QR1KD
	yX3ncLxrVAfP2KBfBI/LkQYqlvilaZKFOfYII4TYD
X-Gm-Gg: AfdE7cnh8gN7a+d1q2xfqbKqbUjFp1r5AsJv5tCYazxn9XsukFiRtHlzOWuaQul3Tvn
	XZwRnSWlZ5tdkD1o0Lo/bN7PqPKGmhf2NvSMBijcOAFhjXUPHi7od1GKf539vz/ComKrmQhajVt
	XmMKhcZoHqggp6kHOEqlBF5u5TyM5rkZ5FITSFPjINzd2VACCa16aDjnfE8gJ+Z4e4tiS9NMwdw
	3HM+QFpTe3XogxTcm1/fk6IqQDVB38U/zOdnbzseXsq7SUeSkAhMO7pfy9JrN3mdVMltM1d899a
	py/krU7cA13OgLVNgs36JYTHnXEpS4hUl9oSv+FstEDc7tXpLfdT6069unM=
X-Received: by 2002:a05:6a21:1f88:b0:3c0:9c19:b27b with SMTP id
 adf61e73a8af0-3c0bcce9940mr4979424637.73.1783555571036; Wed, 08 Jul 2026
 17:06:11 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 8 Jul 2026 17:06:10 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 8 Jul 2026 17:06:09 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <bf56e2e98b512962a2fb88900d535a0e9e6769d8.1782735110.git.ljs@kernel.org>
References: <cover.1782735110.git.ljs@kernel.org> <bf56e2e98b512962a2fb88900d535a0e9e6769d8.1782735110.git.ljs@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Date: Wed, 8 Jul 2026 17:06:09 -0700
X-Gm-Features: AVVi8CdcseowPqFId5ObGoqB8gTqCLO4QEXGH1ZjH1-pjTCLGI84NpwTLe_LrAc
Message-ID: <CAEvNRgEV9VkWHULS4g5hVHu3T6=YZ89HJmkv6rS0+hK=5UFu6Q@mail.gmail.com>
Subject: Re: [PATCH 19/30] mm: use linear_page_[index, delta]() consistently
To: Lorenzo Stoakes <ljs@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: Russell King <linux@armlinux.org.uk>, Dinh Nguyen <dinguyen@kernel.org>, 
	Simon Schuster <schuster.simon@siemens-energy.com>, 
	"James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>, Helge Deller <deller@gmx.de>, 
	Jarkko Sakkinen <jarkko@kernel.org>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	Ian Abbott <abbotti@mev.co.uk>, H Hartley Sweeten <hsweeten@visionengravers.com>, 
	Lucas Stach <l.stach@pengutronix.de>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Patrik Jakobsson <patrik.r.jakobsson@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Rob Clark <robin.clark@oss.qualcomm.com>, 
	Dmitry Baryshkov <lumag@kernel.org>, Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, 
	Thierry Reding <thierry.reding@kernel.org>, Mikko Perttunen <mperttunen@nvidia.com>, 
	Jonathan Hunter <jonathanh@nvidia.com>, Christian Koenig <christian.koenig@amd.com>, 
	Huang Rui <ray.huang@amd.com>, Ankit Agrawal <ankita@nvidia.com>, 
	Alex Williamson <alex@shazbot.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Dan Williams <djbw@kernel.org>, 
	Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>, 
	David Hildenbrand <david@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	"Liam R . Howlett" <liam@infradead.org>, Matthew Wilcox <willy@infradead.org>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Peter Zijlstra <peterz@infradead.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Oleg Nesterov <oleg@redhat.com>, 
	Steven Rostedt <rostedt@goodmis.org>, SeongJae Park <sj@kernel.org>, Miaohe Lin <linmiaohe@huawei.com>, 
	Hugh Dickins <hughd@google.com>, Mike Rapoport <rppt@kernel.org>, Kees Cook <kees@kernel.org>, 
	Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-parisc@vger.kernel.org, 
	linux-sgx@vger.kernel.org, etnaviv@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org, 
	freedreno@lists.freedesktop.org, linux-tegra@vger.kernel.org, 
	kvm@vger.kernel.org, linux-fsdevel@vger.kernel.org, nvdimm@lists.linux.dev, 
	linux-mm@kvack.org, iommu@lists.linux.dev, linux-perf-users@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, kasan-dev@googlegroups.com, 
	damon@lists.linux.dev, Pedro Falcato <pfalcato@suse.de>, Rik van Riel <riel@surriel.com>, 
	Harry Yoo <harry@kernel.org>, Jann Horn <jannh@google.com>
Content-Type: text/plain; charset="UTF-8"

Lorenzo Stoakes <ljs@kernel.org> writes:

> diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
> index db57c5766ab6..f0e5da490866 100644
> --- a/virt/kvm/guest_memfd.c
> +++ b/virt/kvm/guest_memfd.c
> @@ -440,7 +440,7 @@ static int kvm_gmem_set_policy(struct vm_area_struct *vma, struct mempolicy *mpo
>  static struct mempolicy *kvm_gmem_get_policy(struct vm_area_struct *vma,
>  					     unsigned long addr, pgoff_t *ilx)
>  {
> -	pgoff_t pgoff = vma->vm_pgoff + ((addr - vma->vm_start) >> PAGE_SHIFT);
> +	pgoff_t pgoff = linear_page_index(vma, addr);
>  	struct inode *inode = file_inode(vma->vm_file);
>
>  	*ilx = inode->i_ino;
> --
> 2.54.0

For the guest_memfd change:

Reviewed-by: Ackerley Tng <ackerleytng@google.com>

Thank you!
