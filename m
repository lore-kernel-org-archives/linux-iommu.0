Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF94922F1D
	for <iommu@lists.linux.dev>; Thu, 23 Nov 2023 13:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="FBaS2oPe"
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-1f0f160e293so565079fac.0
        for <iommu@lists.linux.dev>; Thu, 23 Nov 2023 05:48:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1700747282; x=1701352082; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eBcUL3xU2f0NaCIYl2Pv/j1l+vUYG7PgqQlNoIpc8KA=;
        b=FBaS2oPekU4XKn8shJQn4p3f/+CUfQZ3hgoINJrUtrTMcBLcA5f0hlPFz3+vkSDOEt
         oN18HIKl4y/qvji0kZVoiTz1qOGl65F5GGGqb2pj1bH/lMZX/AOKbO+DpSjiM1wdueSO
         npd0APqkyGZ1KWqE92CifcKWElwxHiGPpN+pFso+/znCKQiowem3bGTxCN3YYpEZCpzO
         /697W8EUHtw4OtSPy1xdDoeV7oj0i6BCXf1B92GxR/aQIgxRf4jTc07H10WmWn7wyTBF
         TV9KyFHNi1E97P7/R+IScDytY3SdRCHJMuu1RgqGtYFkNOGe07mkXSfqoJz9Ktbb8j9M
         yYRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700747282; x=1701352082;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eBcUL3xU2f0NaCIYl2Pv/j1l+vUYG7PgqQlNoIpc8KA=;
        b=ju/yQbmphwt/VmeG4M7a9UeFoteozMI8Xm9bIOm2mrIaCmmCnsArJQTGvWFim6HdOu
         QKqHjQ3VkHnMQhvKKSfxr+Vu+G6tW8/7Y0FGOIb6un/o+LJbZNocy1GyZLVTDJshCkrx
         RVehlR4x5z91OXi0ozuxPiduscwWBxYgdCEgoz+1iZ3w0CvT4/H7SWHI1NrgGii6Rcy8
         Ur8AKWxQe6dZISiQWpsxM0h/zWBwvaziDarrBszNCe8rC+RmeeGVSk86gQ/43N4D4LKG
         wTluEJy0ftaD0srXC5l40bljesywXsYnaZgEIwaSr8F2C2I0Z0BPdHG3W3MDDgjStZVH
         x1Jg==
X-Gm-Message-State: AOJu0YzMeY+lQZQd3XTDNoi04wsfQCT6EgVJiek/l1fVu95koHMw/aH3
	+H3Wj7U2B6BMv+52DnE6brmVw8S9aPa7H6jAEtw=
X-Google-Smtp-Source: AGHT+IG3ya4ejxAoN/ar5HRnd4khJpq3S9+hTgdc146tuu02dCv5hm94uer6aYKwFjxgH7PaV3Kn8Q==
X-Received: by 2002:a05:6870:280a:b0:1ef:cedd:5c32 with SMTP id gz10-20020a056870280a00b001efcedd5c32mr7008672oab.3.1700747282615;
        Thu, 23 Nov 2023 05:48:02 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-134-23-187.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.134.23.187])
        by smtp.gmail.com with ESMTPSA id pn9-20020a056871d30900b001eace5491c8sm296827oac.18.2023.11.23.05.48.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 05:48:01 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1r6A3k-001op5-Ip;
	Thu, 23 Nov 2023 09:48:00 -0400
Date: Thu, 23 Nov 2023 09:48:00 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Boris Brezillon <boris.brezillon@collabora.com>
Cc: Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	iommu@lists.linux.dev, Will Deacon <will@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	Rob Clark <robdclark@gmail.com>,
	Gaurav Kohli <quic_gkohli@quicinc.com>,
	Steven Price <steven.price@arm.com>
Subject: Re: [PATCH v2 0/2] iommu: Allow passing custom allocators to pgtable
 drivers
Message-ID: <20231123134800.GA432016@ziepe.ca>
References: <20231113101103.1cc05c8c@collabora.com>
 <ZVOgBBEetWf1PFxX@nvidia.com>
 <20231120140425.GA10140@ziepe.ca>
 <20231120153838.2166e7b8@collabora.com>
 <20231120144604.GD10140@ziepe.ca>
 <20231120161418.5eca178e@collabora.com>
 <20231120154536.GE10140@ziepe.ca>
 <6e74bd37-9e10-416e-9fbd-0cebb7948e2b@arm.com>
 <20231122175055.GI10140@ziepe.ca>
 <20231123095141.19dc26d6@collabora.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231123095141.19dc26d6@collabora.com>

On Thu, Nov 23, 2023 at 09:51:41AM +0100, Boris Brezillon wrote:
> Beside, I think your objection that custom allocators are in the way of
> this caching generalization is a bit of an over statement, especially if
> custom allocators provide the same guarantees you get from existing
> allocations (page-backed, no fields used in the page, etc). Worst case
> scenario, you disable the generic cache for all users that pass a custom
> allocator, and add a pr_warn() (or WARN_ON() if you want to be pushy)
> to make sure driver owners take that into consideration quickly.

I want to have common algorithms to manage the radix system, like mm
does, and then have some fairly hairy stuff done in the new common
code to address all the needs we now understand people have. This is
not just "caching".

One of the important things on this list is RCU freeing of the table
memory.

RCU freeing requires precious space in the struct page.

External ops mean we must have the io page table instance available
inside the RCU callback so it knows what op to call to free.

This means the struct page needs to store both a rcu_head and another
pointer.

Currently the similar page table algorithms in the mm side consume all
the free struct page space. I don't expect the future io page table
version of the same stuff to be much different.

So it is not just that the allocator side can't use the struct page
memory. It is that an external allocator inherently demands *more*
space in the struct page, space we may not have to give.

Worse, the entire idea of RCU free seems to be incompatible with what
you are trying to achieve since pages could be unavailable for use
while they are waiting in RCU.

I'm looking at this and thinking we loose the option to do RCU in the
generic code to accommodate external ops. "make RCU optional" is
basically saying to duplicate alot of stuff because RCU becomes pretty
fundamental to features and algorithm design.

Do you understand my alarm to this direction better now?  I'm sorry if
I haven't explained this clearly enough. (I'm coming at this from the
MM perspective where the sorts of algorithms and problems here are
already well known)

> unresponsive and reluctant to change how they use the APIs. So, if I
> follow your way of thinking, you'll just be stuck in the same place,
> waiting for DRM drivers to accept the transversal changes you intend to
> push.

I wasn't imagining a forced API change. I think the current API can
work fine along with an optional pre-allocation scheme.

> What I strongly oppose to though, is having someone say 'I have the
> perfect solution for you', and then tell me, 'but you have to wait
> another six months, maybe more, to see what it looks like'. 

I never said you should be blocked. I agreed with duplicating if
necessary to be unblocked.

I also outlined and encouraged you to solve the general problem, but I
fully understand you don't want to take it on. That's fine too.

You are both mis-characterizing my position as trying to block the DRM
driver :(

I'm trying to accomodate the work I see we need to do soon on the
enterprise iommu side that touches this same code.

Look, if we go down this road then we may end up duplicating the page
table code so the iommu drivers can use the improved versions until
the DRM driver can be changed. Maybe doing duplication later is better
than sooner.

Jason
