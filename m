Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D692115AE6
	for <iommu@lists.linux.dev>; Tue, 18 Jul 2023 18:29:29 +0000 (UTC)
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6686c74183cso6046105b3a.1
        for <iommu@lists.linux.dev>; Tue, 18 Jul 2023 11:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1689704969; x=1692296969;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=S7o51YlRNS3zPl1LsUYTJR0KoGseri+clhYp1sqA+7o=;
        b=i3PLfLk9r7NY7Uevj6PA3cYqDyv4GmY8ZTpAyOTEMVm18YLHoILcZ61oG+F9iFTHtV
         OX8jgLzmPYLYjT5nTvuf48EZuGhjT3nXDpUtIzZoLmFT/vwScgj8TKUey6e+GcVODdO/
         aR6/yFWorh49MLpPBPS4KJKiFuCN20/QPxl/yYbUzWAditSFcUD4YBXKid/OyWwMGSU4
         hTdhkYgK99mIeIotW/7zP2M7qvX9TABdVEY82e39977TCXOnZTAAMs6Q2HmEVszoN4iv
         VRVVMQY0DZtRHIz7VWFEh8j8Dqyv1YGRYWzfSCH0PzDWSbsFyOPnQYwqfHvs+eC+iMQF
         VveA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689704969; x=1692296969;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S7o51YlRNS3zPl1LsUYTJR0KoGseri+clhYp1sqA+7o=;
        b=Co2Dmkfly3g6DabQz8Df9fyftw55qaTz4GQmhK5oJTglMK92QIg9wj5X6zPrngJRkB
         heDTt8A/QVehOZN6ZHApF41XJLKgKy3hD+SmD55LTCZ5G6XSaQb7xij9Ec8EpKJyyCQB
         kktUmHD8UrufHXd/2XuqXDrY4coW5Xn7937CaNdeW5qhiLZTMdY+HAJedBYOfwGsOENi
         s3IoZG3Qa5q2qf6ar/FZsYcpb4WzMH5c90z72mdUjSl93HqoIEtdXLiOSG18dV5lhRXV
         +DhPTkyK+iCNT0Q/ev19Cl20H+G5rjGDd5OTxdD4aIR2nrL4WiDRRYprGVi/b+hxM9iD
         mTBA==
X-Gm-Message-State: ABy/qLb7Kip9O1bfrAqYHrIMemoLcVHs3kAfMzaQeJ8nM+NhuvRmb5FU
	HfrDP+2EBC3YgbBSBDQJlSiKIQ==
X-Google-Smtp-Source: APBJJlGRXuPRhwkyVNmCMc2KhNqjSUeDWEj142071UHQ2p4xg0uemtxHiHrQn61P1ux7F7gEcQuZIA==
X-Received: by 2002:a05:6a00:3a1d:b0:668:8705:57cf with SMTP id fj29-20020a056a003a1d00b00668870557cfmr19016531pfb.25.1689704968961;
        Tue, 18 Jul 2023 11:29:28 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id u21-20020aa78395000000b0065434edd521sm1797726pfm.196.2023.07.18.11.29.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 11:29:28 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1qLpRu-002ayW-Jq;
	Tue, 18 Jul 2023 15:29:26 -0300
Date: Tue, 18 Jul 2023 15:29:26 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Alistair Popple <apopple@nvidia.com>, ajd@linux.ibm.com,
	catalin.marinas@arm.com, fbarrat@linux.ibm.com,
	iommu@lists.linux.dev, jhubbard@nvidia.com, kevin.tian@intel.com,
	kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au,
	nicolinc@nvidia.com, npiggin@gmail.com, robin.murphy@arm.com,
	seanjc@google.com, will@kernel.org, x86@kernel.org,
	zhi.wang.linux@gmail.com
Subject: Re: [PATCH 3/4] mmu_notifiers: Call arch_invalidate_secondary_tlbs()
 when invalidating TLBs
Message-ID: <ZLbaBpfaAqigFzIT@ziepe.ca>
References: <cover.b4454f7f3d0afbfe1965e8026823cd50a42954b4.1689666760.git-series.apopple@nvidia.com>
 <791a6c1c4a79de6f99bffc594b53a39a6234e87f.1689666760.git-series.apopple@nvidia.com>
 <20230718111759.5642b4c4ffd72ddd9c8aa29f@linux-foundation.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230718111759.5642b4c4ffd72ddd9c8aa29f@linux-foundation.org>

On Tue, Jul 18, 2023 at 11:17:59AM -0700, Andrew Morton wrote:
> On Tue, 18 Jul 2023 17:56:17 +1000 Alistair Popple <apopple@nvidia.com> wrote:
> 
> > The arch_invalidate_secondary_tlbs() is an architecture specific mmu
> > notifier used to keep the TLB of secondary MMUs such as an IOMMU in
> > sync with the CPU page tables. Currently it is called from separate
> > code paths to the main CPU TLB invalidations. This can lead to a
> > secondary TLB not getting invalidated when required and makes it hard
> > to reason about when exactly the secondary TLB is invalidated.
> > 
> > To fix this move the notifier call to the architecture specific TLB
> > maintenance functions for architectures that have secondary MMUs
> > requiring explicit software invalidations.
> > 
> > This fixes a SMMU bug on ARM64. On ARM64 PTE permission upgrades
> > require a TLB invalidation. This invalidation is done by the
> > architecutre specific ptep_set_access_flags() which calls
> > flush_tlb_page() if required. However this doesn't call the notifier
> > resulting in infinite faults being generated by devices using the SMMU
> > if it has previously cached a read-only PTE in it's TLB.
> 
> This sounds like a pretty serious bug.  Can it happen in current
> released kernels?  If so, is a -stable backport needed?

There are currently no in-kernel drivers using the IOMMU SVA API, so
the impact for -stable is sort of muted. But it is serious if you are
unlucky to hit it.

Jason
