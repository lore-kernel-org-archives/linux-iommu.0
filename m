Received: from mail-dl2-f43.google.com (mail-dl2-f43.google.com [74.125.229.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E09324E0B8F
	for <iommu@lists.linux.dev>; Fri,  2 Oct 2026 15:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790953733; cv=none; b=D6OGNFer4cPFuXg/Z88RpJib+W/vUYzmekvT1R6V7tkceVPjmkfSZNJgXkrhH8aFGzgt747G3d1slW97i8CeuOIWlhbh2mrzd67N4Xhf54ueY4CBjlQdWcrwZqC5zwo2x2xxY3f0iQOhykSfcyEion+gVe/wIfiCOIuZgVxOsAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790953733; c=relaxed/simple;
	bh=rN2GiY5/HkyS1I9EgmemypM94IRF9h269bCwt6E9FiE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NHrxtKcmuseCZq0tLQUeD3iFSmSaZY9rr3R/GCZZKUaDDvLNv3Mv4AMX7wwokrVIP/KoZ4ljz09y4S6nxIAMiv5W4CwsVDPSEwm3WejQjr+ch6ngXH5vBwS+om4OymxoZ8p0s5wmkrQ7z+r3BNZlzmUXOynTfKfXGMxKWViRIqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=UQsrUeqX; arc=none smtp.client-ip=74.125.229.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="UQsrUeqX"
Received: by mail-dl2-f43.google.com with SMTP id a92af1059eb24-1450541ab18so8551434c88.0
        for <iommu@lists.linux.dev>; Fri, 02 Oct 2026 08:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1790953728; x=1791558528; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ENyCFbokdLWAmAh2KCAVPVZPtiPMjF2AJu3KZcFQdKM=;
        b=UQsrUeqX+Ns9l4k5O8rLo+0qHgU9WyjubsqmUmpoOtuPUwITZoDDqWcSDp5tNDwiZT
         zFT7HJMuc1WuEC0z3FAVu6o5iLVDrHtNTTqyvoaFqLImsRKISEEqDy0miObSbn0Ifoad
         1T/kdlRHu46oAGiV0Ma06wET8h6i8W4aHk/f25JMMyJ/TXGNNTABScYJCDCGjEPGRbvX
         Al17tZAc+2B6ikJcSkM1lAY+aXFdEh4G0G+iPEuJZwDJ1/0rmJ6Y7vM0NFkhNQM1Y/dI
         KZwbWzr2WBh29aYKPVvnBptQkVB7dLxPG+6v85hC/fTrlO4HNNUZLllQbNUAzTXFurRi
         WF+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790953728; x=1791558528;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ENyCFbokdLWAmAh2KCAVPVZPtiPMjF2AJu3KZcFQdKM=;
        b=aJTG51VrEP01eve+j9YUq9A2XgSfBfBG7FXaWIkSO6Bt5CC8z+NPmhZ0uS5pk06uqV
         ni5dPCkn3QK+ztP29Nh5RLtCsVQ/JoKLFOPS3t3vb62ARB/6wDGU1qvOhApT6SuFU5CM
         i/invky+S9x0crycwx5O4p+PehHq26xK8CutSxnHvUsWZdUAkubhN8LFJ8IlshRE0k0M
         /xQmQKHmnqteI6be8h8D7/nzKLyj3jVj7stcLOwGxj6+4pRqPw6a8Vd4Q2dqCRLYoUjy
         8880Nn3j6UPCHo8jI2ASdmtfPQBnHWBNSi7nmeYurpu7AZZ2xrubCgrEtjwwSx7dypyy
         du1g==
X-Forwarded-Encrypted: i=1; AKwUvBzZypTucTd9BtvGwCNad8pLqcu7xt+GoUkMikWiJMUQCqMIi1kmJkNrgHgAn6F/MCs74b0e+A==@lists.linux.dev
X-Gm-Message-State: AFuF++kxp0+XPJRfl8n2yBIFd1d/BEpTGsuTHhPNotjwNMF45JO3jaYW
	QF92L3QxolMIpCnFKntBhzTNoJLScwaVNnRNbdKC60P5ie3zch4GbuA0o5kwcvG/Qbs=
X-Gm-Gg: AYBFou3dOXvLx7hR2VUC1vVg4pBOm/GAei8cCGMKnpnmWwHv72GIfUIrdjS4i9+Y+Fg
	yNalqn369OH824nnwmqr+P3Aw26oi4JSC+K1vYe/0EX8ZefyrNJ7fXQXMXuLaT24KwR0flDjlBx
	05HfeL02qusBHDJqYC1iMwF5YMC/EuBJBe8p52CcDSIJhe1TnRbq6zvDKmzxVyvBRRogNTR5kxO
	XH7Weu8WdRfTt7Qj/XQdFRciyZMHTPR83N4yxV18w37atRjeLxZnc7lTL9m2anHwBbTV7UMjp+X
	tyLkGZzD0CIT6PkuFUnuBoBGg4D5s/cZyggdM9FxzImwvxJ8fqqo2ZVuS4t0X/dpFDcyLeGWews
	cScEI1PInruVWBjk07bxxchbblJnsBixomxmttW0NF4YWJ6XhmqSt+3z5aM49Zvuwa7Y4ggliRo
	sd0e/cWjNOeIlfeYYsvGqGzsXBjM+rI8jrMwmmDRER2m22
X-Received: by 2002:a05:7022:ed04:b0:14c:d8d9:94fb with SMTP id a92af1059eb24-14f5c3f1c17mr2903275c88.23.1790953726759;
        Fri, 02 Oct 2026 08:08:46 -0700 (PDT)
Received: from ziepe.ca ([130.41.10.202])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14f468c08absm6704330c88.8.2026.10.02.08.08.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 08:08:46 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xCesO-0000000Gmdt-3ju7;
	Fri, 02 Oct 2026 12:08:44 -0300
Date: Fri, 2 Oct 2026 12:08:44 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Pranjal Shrivastava <praan@google.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Mostafa Saleh <smostafa@google.com>,
	Daniel Mentz <danielmentz@google.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Logan Odell <loganodell@google.com>, iommu@lists.linux.dev,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/5] iommupt: Introduce IO page table shrinker
Message-ID: <20261002150844.GC3481470@ziepe.ca>
References: <20261001230219.818128-1-praan@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261001230219.818128-1-praan@google.com>

On Thu, Oct 01, 2026 at 11:02:14PM +0000, Pranjal Shrivastava wrote:
> Introduce a lockless, deferred reclamation framework for IOMMU page tables
> built on the generic_pt library. As VMMs and userspace drivers map and
> unmap large, sparse IOVA regions through VFIO and iommufd, page table
> directories are often left allocated but completely empty. generic_pt
> frees a table when a single unmap covers it entirely, but tables that
> empty through a series of partial unmaps stay allocated until the domain
> is destroyed. Under memory pressure, this *stranded* memory cannot be
> reclaimed and has resulted in OOMs.
> 
> This series refcounts leaf directories natively in struct ioptdesc and
> registers a domain-aware MM shrinker that prunes empty directories under
> system memory pressure.

We had talked about doing it this way

But I had proposed a different, and possibly simpler, solution that
addresses *just* the iommufd use case.

After unmapping something have iommufd compute the gap in IOVA that
contains what was unmapped and then issue a 'clean(gap)' operation to
generic_pt.

This is the same operation as unmap, except we know now that the gap
has no PTEs so all it does is clean up the table pointers.

This requires no special refcounting or anything difficult beyond
some locking in iommufd to hold the gap stable while we clean it.

Would it work for you? It seems substantially simpler, but I never
tried to implement it.

An alternative version is closer to what you have here, somehow
connect iommufd to the shrinker and have it lock and walk the gaps
cleaning them on shrink requests?

iommufd has no trouble walking the gaps in the interval tree, there is
a helper that does that computation.

Jason
