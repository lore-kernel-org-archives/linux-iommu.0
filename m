Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 146A6285058
	for <iommu@lists.linux.dev>; Fri, 22 May 2026 16:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779466452; cv=none; b=p5Ztsef9oYYAK2VUhaTKEjwDsqpqaW+vjQ2arEVAp6KcMsxDgVEXzmw2EvqOiTi+YZuIRpn5nCu0cqRgN9MqFSEwPMxkhto8rrw8pp2ZieC1aCeIlDTmUz6h6+kfgVgrJtRbKbh1u7YZ12ea+4yQlYX1KuEFgWdW+PVYLKPoaIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779466452; c=relaxed/simple;
	bh=QsZ2biNFsqwFiV9jdFAUogBn9H5YKkXmS0NpOnvA0vc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IF46AmpIG4tc9+i3UtsMDbxY4/Z1mBAwSI/ufDGPYsYkv48hzfa0T0Ioge4T09Hi8r3C9yoZZYwouAtU9YDpaSNkBhaD9Y6YxPH/y7yMFDHqD5rnTbqkaU5LddMC4p/I177Dl7KZjV5luuDjG2OQE58BDdRL+77WOnjILcpqVSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=A7ZkE/6T; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="A7ZkE/6T"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2b46da8c48eso405ad.1
        for <iommu@lists.linux.dev>; Fri, 22 May 2026 09:14:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779466449; x=1780071249; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Cx+dP+hmSAXKr5MZgKel2k2lDy4SUxKpYpFDbZZsZBU=;
        b=A7ZkE/6TDdWjioK0+/pqW2C0W8s8jNMOVecvwG0qeuZkT93xnDPqneOpB1/XSVL8Jj
         FrocP8FoYqkXKVCR24vmVmK5+W3GEfvgClIqqqO34ZTlNNzDRf3IBmkqPQ7la2qdmUjz
         VJf8ngUZOGlsGdN+Jfx/CUXTHkybH46w6d149ONgnKdA9Hjam8IkSeVd6uk0i8XToRL7
         lgZ2JqMKwdiUVmUhBK2wRN02XgWzi37zwcRckqfZpzIaZuVzNYBt9enDjNIjW7zzwyA7
         aniBIDQ4poZGqlEfJbIZxP83o66YwvC+Q7U9l360r2mlKiH1XDKACRxphjpAwOXsPwlQ
         jHDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779466449; x=1780071249;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cx+dP+hmSAXKr5MZgKel2k2lDy4SUxKpYpFDbZZsZBU=;
        b=XvalZmf5uPx8LrWUZsuxg/0OrPIOsxKgKIZmVNuRQV/GmwggCwhPBqfYSXCOdsGEGv
         +UFiin25I1eSbyYqEarpKhwFlXIlGorNHxHTu8xDbvPxWG2W8fKG2sC5EaqfuG5wP7Un
         XlYA0g7S7u9Mb+Ma/kvwhx0SiUi7EQE6OAbyQ3HEZUPTNPs2PvWFWQLWmOlzI3daMQaX
         Md2Y5ppRrPKoqGdlP8vUi8knDSVhuX//iTJbS6UnuYqtCnwQvkVlfngzaapTK+SvEa6R
         BRsdA8rqgRKytztqAeGbkz97AoUoGMnXfC1oBRuY59GuxkLYORRW1YquTnaVatrsI00s
         BF8A==
X-Gm-Message-State: AOJu0Yz8ha33pqTlf6x3PTRyxr785Mf19R8Yeg5IczfHSl4CUtJnuqqt
	EUESC0Y0ixxYIhh25gsGCASbD0T25v28xwjX6S3Bn2wyHf4fFNhFTfghfd6p+KT8bw==
X-Gm-Gg: Acq92OHBuSQ9R/hd6us+0sCQ8ZyKKEJyIDGdGh6lY33c/OmTuuQfKw8lZeW23LGVZ/Q
	spfUhWtyMfLgLvDo2+J2ESz0pONXWaruSDcc+DFoCV2OiOPv7qRa1rpwhu6MVTaSjqpyC+iKAP+
	Y1vJLBpXyMi9wBjW6a/k90ETPdPaO7oeGYr3cGP9lX42XcMQqGvsDM/HNwdz2yFgwXQvUuaYVyO
	nTjDwX4ltxFb/03aOgE6sUvtRbnHMtX0phwHtM9oA4x2KdKIM+xjCLw1N+woAfaaCguaWaWsxxs
	rD/mBdF8S4iw2yTS8xteIYlhBW3Vl4Hhk2XH06+VI5tTKsGL1ON1VDkmquqXws537AXcDHVbTHQ
	wZQeD83vboDR/8DdiKtp9Hvgr92DghRbDhvxuVkDzPUQPsJYboxOjuRWUCgBTabm6cVgo24GJj+
	p4aHMslKjJpdilLa0peHzwALj+rpM5qf76Cxqy1MRY4jZGl7Az003HvZHIhv5Sw1jXAd2QgxbBD
	+ByJ4E=
X-Received: by 2002:a17:902:d2cc:b0:2bc:a58c:fd7a with SMTP id d9443c01a7336-2beb1a59b79mr2204035ad.16.1779466448755;
        Fri, 22 May 2026 09:14:08 -0700 (PDT)
Received: from google.com (44.234.124.34.bc.googleusercontent.com. [34.124.234.44])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2beb569592dsm21372045ad.16.2026.05.22.09.14.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 09:14:08 -0700 (PDT)
Date: Fri, 22 May 2026 16:14:01 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: iommu@lists.linux.dev, linux-pci@vger.kernel.org,
	Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Mostafa Saleh <smostafa@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Daniel Mentz <danielmentz@google.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	David Matlack <dmatlack@google.com>
Subject: Re: [PATCH v3 3/3] iommu/arm-smmu-v3: Fix ATS state tracking via
 ats_prepared gate
Message-ID: <ahCAyZ_-2_CLIqPR@google.com>
References: <20260519135323.1558777-1-praan@google.com>
 <20260519135323.1558777-4-praan@google.com>
 <20260519144430.GI7702@ziepe.ca>
 <agx5-jFkU2skyEos@google.com>
 <20260519145947.GK7702@ziepe.ca>
 <ag3EL10WAIImL9XR@google.com>
 <20260520145142.GU7702@ziepe.ca>
 <ag3gJLtY1jnT17Zv@google.com>
 <20260520163117.GX7702@ziepe.ca>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260520163117.GX7702@ziepe.ca>

On Wed, May 20, 2026 at 01:31:17PM -0300, Jason Gunthorpe wrote:
> On Wed, May 20, 2026 at 04:24:04PM +0000, Pranjal Shrivastava wrote:
> > On Wed, May 20, 2026 at 11:51:42AM -0300, Jason Gunthorpe wrote:
> > > On Wed, May 20, 2026 at 02:24:47PM +0000, Pranjal Shrivastava wrote:
> > > 
> > > > However, I'm thinking what's the right thing to do if pci_enable_ats() 
> > > > fails in attach_commit():
> > > > 
> > > > 1. Fail to attach but unmerging the invs_array entry is complicated.
> > > 
> > > Is it? We should be able to keep the the original invs and not free
> > > it, just put the pointer back?
> > 
> > Reverting the invs pointer itself is straightforward, but IIUC the 
> > current implementation of arm_smmu_install_new_domain_invs() is a
> > destructive update as it calls kfree_rcu() on the old list immediately
> > after the swap.
> > 
> > Although, I guess we could refactor the RCU lifecycle to defer the 
> > kfree_rcu until after pci_enable_ats() succeeds in the commit phase?
> 
> Yeah..
> 
> Though really pci_enable_ats is not working the way we want, writing
> the enable register can't actually fail - it is all the sanity
> checking for kernel bugs that is the problem here.
> 
> How about call pci_ats_supported() early in attach and fail, then if
> pci_enable_ats() fails just WARN_ON and keep going, kernel bug.
> 
> Re-organize pci_enable_ats() so it relies on pci_ats_supported() for
> all the sanity checks and cannot fail if supported is true.

Hmm, IIUC, the current situation says: 

pci_ats_supported ==> ATS cap check
pci_prepare_ats ==> ATS enablement prep 

Thus, I feel if the prepare fails, we should expect enable to fail. But
if prepare succeeds but enable didn't, that's the place we should
WARN_ON and move on.. because we (IOMMU) did the best we could have..

With the updated variants of pci_ats_support / pci_prepare_ats (in
patches 1 & 2), I believe we cover all the cases now..

And we plan to call prepare_ats only if (pci_ats_supported == true)

Thus, if prepare_ats failed, we fail at probe. And if probe succeeds but
enable ATS failed, that's something the IOMMU can't help with, hence we
WARN and move on? Does that sound good?

Thanks,
Praan
