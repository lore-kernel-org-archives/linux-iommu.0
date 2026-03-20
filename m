Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 526643C455E
	for <iommu@lists.linux.dev>; Fri, 20 Mar 2026 18:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774033015; cv=none; b=Cd5oddDZMa1PAECpwld68vd7SNQt0w/ZXDyOBeZZEckIyzXN8vgwfn4ynqP4r/Ages9o2UFC5r8aZbbUdsQmMjXkEXDyP/9L4fwdujAgJiykAv9VGyqbW1Ks+ltK24L2dNbtuLQUX1pDmoSUYC0K7+R0xa0Emow/Ddm0QW+8qy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774033015; c=relaxed/simple;
	bh=Q5uRXNQyxitxk6w+eL0zYDDaRm1GUZUbF3kikSQDSPM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HIg+CraudG8BbW9NX1IeaUeZ3vFn36sICF+z0fJVomUbNugdiY7RhF3LXgmvjizUhu95IVHQLovJmdoe9jHrpAyspsl82wVJwM9fY0kokaCIFRuKWQI8WUWlNXoAK6NfDrECcsa7Qvg3BRpVHaYnkdAEhryABSbbkVA7sdQM7xY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sC3k4MlU; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sC3k4MlU"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2b052562254so16995ad.0
        for <iommu@lists.linux.dev>; Fri, 20 Mar 2026 11:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774033014; x=1774637814; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mzX6nj4ei+Q5c66+o1zUOgOGvSVephsLWbWHR4XH47E=;
        b=sC3k4MlUgRGoK6MTDarnExbvzs87JeUGJBd5wDz8YsG7XyzY8l0dndOxTD0mFYQFCe
         XpArIkRP9jf/z0eD/FMUtaRl9FgsvGr7fUV0TTWiWvTatNOpOXIc1UaAWC2Uwog33fr8
         7stAHYdAZd3XoywaqouKWKjniwCNjIk4Nn1URUnNsT7GLP3kMrfXghkcRrdNiACNNMa5
         BZG0erWOm7y3s/NCgbFw3c8+Na9A+8VsKmObOCdY7q84GxhyZm1IZ+kFQfYkK8Yp+j4x
         G2HTtbbvT7AZclWh8hf9osunvA58Zqhk6NcVoMKMA6o/gTrEFuL8byUfxQ+i9L7rfrtW
         XpFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774033014; x=1774637814;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mzX6nj4ei+Q5c66+o1zUOgOGvSVephsLWbWHR4XH47E=;
        b=m3Nxftlemx1LxHgcGkXMA+E7w2NZTh3UXJuLgu/EG0aEcwrOHcn0UrPgOOaOCsAPdn
         BVDj3kv/4F6oPR49t7sV8V+OAMv4sxkeli+v+tWdyCUrA8OESJ02Of3iDs7d832wKVZ3
         ZY+zm9mXh2oq22c+nLcoC8GD3FdRMSgNH6B5Ml5MA5RVaVpXQN1bgNbiHWbi4If2Yah7
         0bUTzIMdfUF+0rYDNl4sLl5wnJAXkODCiG+EFG6QZL3Nat10p4AFrzrCG4GyDfPAAw5w
         gp38jfInud0pzS9b80mMgrd7TfYn5z1KjRHgYKOQElDIHRa8o25WdmPrrJ/4ORY+QXNu
         YuRQ==
X-Forwarded-Encrypted: i=1; AJvYcCWsBHaZvTigYBA1ZbzBJ07p7HapxWs9pT4Nc0IZ5xNgrmER/jp0jGjRqZkLnMh9wGc83lSQMw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxZQcsxPIi0TzCdRtUnb4XMx1ltrTVaH7jk50ea39ryZrQ4Jz6i
	A3H3dWCi3/jynb6WVndh9jubtXF0VhmV1TVMD5UtTv0tSzAED1DspF5Ye+C+152dcA==
X-Gm-Gg: ATEYQzw8Zn+5JaWW0qgiR94tYtKCtjeEIY4ybCa45kwQqvxqnQp1J8YBQony03PEj3T
	rv2xpYLMUiLi54aS6r65IFDnuIs8rfxeuLDt0QOBzZv5iWhUI/asWpHIW8eIVT7YTZL7SZmSYDZ
	uwH60/WaNknRaj8xqCKQvj/DN5eec/5ZEH0jK9UU7TMhLZ54G+gebF5ScibwwESgZiGQVTCF6IX
	TSajTix/NhraO+TNv5b9VmGccE7qX/KnDLalAquta93JfVne2GY76velGTdpbo19PCcEY2zCPr5
	bNQ0gfUeznbUwdReJu/eirouPSNhXEVupyy18kOKTS0Qp2a9Ikyy2AwmiOXt7ZW0X9RRniW/j1V
	YFKPbPcO5rp+NXt31n8YH14ezoi98mY9nFl3w553IpgBeqxl1e4uldZjiLRO+pC9nQPPl2kxy0V
	dYcRQfwlK/xG14DOzu/CkZmsv5Oal/0bs379bPhvVCxf/ZD2MvOeqGVJ//0Zm9cA==
X-Received: by 2002:a17:902:cf45:b0:2b0:5193:1212 with SMTP id d9443c01a7336-2b08b40a7b1mr321455ad.4.1774033013040;
        Fri, 20 Mar 2026 11:56:53 -0700 (PDT)
Received: from google.com (168.136.83.34.bc.googleusercontent.com. [34.83.136.168])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c743a8186efsm2341998a12.13.2026.03.20.11.56.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 11:56:52 -0700 (PDT)
Date: Fri, 20 Mar 2026 18:56:48 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Pranjal Shrivastava <praan@google.com>
Cc: Vipin Sharma <vipinsh@google.com>, 
	David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>, 
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Robin Murphy <robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>, 
	Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>, 
	Adithya Jayachandran <ajayachandra@nvidia.com>, Parav Pandit <parav@nvidia.com>, 
	Leon Romanovsky <leonro@nvidia.com>, William Tu <witu@nvidia.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	David Matlack <dmatlack@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Chris Li <chrisl@kernel.org>, YiFei Zhu <zhuyifei@google.com>
Subject: Re: [PATCH 04/14] iommu/pages: Add APIs to
 preserve/unpreserve/restore iommu pages
Message-ID: <ab2SoJqbwyL4luaw@google.com>
References: <20260203220948.2176157-1-skhawaja@google.com>
 <20260203220948.2176157-5-skhawaja@google.com>
 <20260317202925.GA2582517.vipinsh@google.com>
 <ab0pBc2-Yr7qo-2G@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <ab0pBc2-Yr7qo-2G@google.com>

On Fri, Mar 20, 2026 at 11:01:25AM +0000, Pranjal Shrivastava wrote:
>On Tue, Mar 17, 2026 at 01:59:03PM -0700, Vipin Sharma wrote:
>> On Tue, Feb 03, 2026 at 10:09:38PM +0000, Samiullah Khawaja wrote:
>> > +
>
>[------- snip >8 --------]
>
>> > +EXPORT_SYMBOL_GPL(iommu_unpreserve_pages);
>> > +
>> > +void iommu_restore_page(u64 phys)
>> > +{
>> > +	struct ioptdesc *iopt;
>> > +	struct folio *folio;
>> > +	unsigned long pgcnt;
>> > +	unsigned int order;
>> > +
>> > +	folio = kho_restore_folio(phys);
>> > +	BUG_ON(!folio);
>> > +
>> > +	iopt = folio_ioptdesc(folio);
>> > +
>> > +	order = folio_order(folio);
>> > +	pgcnt = 1UL << order;
>> > +	mod_node_page_state(folio_pgdat(folio), NR_IOMMU_PAGES, pgcnt);
>> > +	lruvec_stat_mod_folio(folio, NR_SECONDARY_PAGETABLE, pgcnt);
>>
>> Above two functions are also used in other two places in this file, lets
>> create a common function for these two operations.
>>
>
>I was thinking about this, out of the 2 other places one is
>`__iommu_free_desc` where we are supposed to subtract pgcnt.. but I
>think we can follow the -pgcnt pattern we have currently and add a
>helper `iommu_folio_update_stats(folio, pgcnt)` where we can pass -pgcnt
>to subtract nr_pages? Something like:
>
>+static inline void iommu_folio_update_stats(struct folio *folio, long nr_pages)
>+{
>+	mod_node_page_state(folio_pgdat(folio), NR_IOMMU_PAGES, nr_pages);
>+	lruvec_stat_mod_folio(folio, NR_SECONDARY_PAGETABLE, nr_pages);
>+}
>
>@@ -86,8 +91,7 @@ static void __iommu_free_desc(struct ioptdesc *iopt)
> 	if (IOMMU_PAGES_USE_DMA_API)
> 		WARN_ON_ONCE(iopt->incoherent);
>
>-	mod_node_page_state(folio_pgdat(folio), NR_IOMMU_PAGES, -pgcnt);
>-	lruvec_stat_mod_folio(folio, NR_SECONDARY_PAGETABLE, -pgcnt);
>+	iommu_folio_update_stats(folio, -(long)pgcnt);
> 	folio_put(folio);
> }
>
>But I'm unsure if passing -(long)pgcnt is a good idea?

mod_node_page_state() takes last argument as "long" and I can see other
examples of passing -folio_nr_pages(folio) directly into it. So we can
just keep it as following:

iommu_folio_update_stats(folio, -pgcnt);

I think it is a good cleanup. I will update this in the next revision.
>
>> > +}
>> > +EXPORT_SYMBOL_GPL(iommu_restore_page);
>> > +
>
>Thanks,
>Praan
